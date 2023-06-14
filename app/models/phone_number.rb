class PhoneNumber < ApplicationRecord
  has_many :messages

  module Status
    ALL = [
      NEW = "new",
      VALID = "valid",
      INVALID = "invalid"
    ]
  end

  after_initialize :after_init

  def after_init
    return unless new_record?
    self.number_status = Status::NEW
  end

  validates :number_status, inclusion: { in: Status::ALL }


end
