class Message < ApplicationRecord
  belongs_to :phone_number

  module Status
    ALL = [
      NEW = "new",
      SENT = "sent",
      DELIVERED = "delivered",
      FAILED = "failed",
      INVALID = "invalid"
    ]
  end

  after_initialize :after_init

  def after_init
    return unless new_record?
    self.message_status = Status::NEW
  end

  validates :message_status, inclusion: { in: Status::ALL }
end
