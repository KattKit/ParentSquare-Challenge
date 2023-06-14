class MessageBlueprint < ApplicationBlueprint
  identifier :id
  field :message_status, name: :status
  field :phone_number_id, name: :to do |message, option|
    PhoneNumber.find(message.phone_number_id).phone_number
  end
end
