class MessageService
  # TODO: event concerns should be moved into an EventService

  TIMES_TO_LAST_SUCCESS_QUERY = <<~SQL
    SELECT MIN("created_at"), MAX("created_at"), "tags", ("data" -> 'success')::boolean
    FROM "events" 
    WHERE $1 = ANY ("tags") AND NOT ("data" -> 'success')::boolean 
    GROUP BY "tags", ("data" -> 'success')::boolean
  SQL
  TIMESCALE = [
    :immediate,
    15.seconds,
    30.seconds,
    1.minute,
    5.minutes,
    10.minutes,
    20.minutes,
    40.minutes,
    1.hour
  ]
  def self.create_message(to_number, body)
    event = Event.new(data: {
      to_number: to_number,
      body: body
    })
    phone = PhoneNumber.find_or_create_by(phone_number: to_number)
    phone.number_status ||= PhoneNumber::Status::NEW
    return OpenStruct.new(success?: false, message:"invalid phone number") if phone.number_status ==
      PhoneNumber::Status::INVALID

    message = phone.messages.new(body: body, message_status: Message::Status::NEW, remote_id: nil)

    phone.save!
    message.phone_number_id = phone.id
    message.save!

    event.tags = [
      [PhoneNumber.name, phone.id].join(":"),
      [Message.name, message.id].join(":")
    ]
    event.save!

    SendMessageJob.perform_later(message_id: message.id)
    return OpenStruct.new(success?: true, message_object: message)
  end

  def self.update_message(remote_id:, status:)
    message = Message.find_by!(remote_id:)

    event = Event.new(data: {
      remote_id:,
      status:
    })

    event.tags = [Message.name, message.id]

    message.message_status = status
    if message.save
      event.save!
    else
      event.data.merge!(success: false, errors: message.errors.full_messages)
      event.save!
    end
  end

  def self.send_message(id, resend_time = :immediate)
    message = Message.find(id)
    
    _send_message(message.phone_number, message, resend_time)
  end

  def self._send_message(phone, message, resend_time)
    client = Api::LoadBalancer.score_past_calls(_get_times_to_last_success(message)).get_client()
    begin
      remote_id = client.send_message(phone.phone_number, message.body)
      Event.new(data:{
        remote_id:,
        status: Message::Status::SENT,
        success: true
      }, tags: [
        [Message.name, message.id].join(":"),
        "Client:#{client.name}"
      ])
      message.message_status = Message::Status::SENT
      message.remote_id = remote_id
      message.save!
    rescue Faraday::ServerError => e
      Event.new(data: {
        error: e.message,
        success: false
      }, tags: [
        [Message.name, message.id].join(":"),
        "Client:#{client.name}"
      ]).save

      resend_time_index = TIMESCALE.index(resend_time) + 1
      if resend_time == :immediate
        SendMessageJob.perform_now(message_id: message.id, resend_time: TIMESCALE[1])
      elsif resend_time_index == TIMESCALE.length
        raise e
      else
        SendMessageJob
          .set(wait: TIMESCALE[resend_time_index])
          .perform_later(message_id: message.id, resend_time: TIMESCALE[resend_time_index])
      end
    end
  end

  def self._get_times_to_last_success(message)
    conn = Event.connection
    conn.select_all(TIMES_TO_LAST_SUCCESS_QUERY, nil, [[Message.name, message.id].join(":")]) || []
  end
end