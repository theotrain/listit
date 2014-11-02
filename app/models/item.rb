class Item < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true, length: {minimum: 3}

  def self.to_db_time(dt)
    dt.in_time_zone("Pacific Time (US & Canada)")
  end


end