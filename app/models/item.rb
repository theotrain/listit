class Item < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true, length: {minimum: 3}

  # before_save { |item| item.sms_time = item.sms_time.utc }

  def self.to_db_time(dt)
    dt.in_time_zone("Pacific Time (US & Canada)")
  end
end