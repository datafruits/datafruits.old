class Show < ActiveRecord::Base
  attr_accessible :time, :title, :user_id, :description, :time_zone

  belongs_to :user

  validates_presence_of :time,:user_id

  def start_time
    time
  end
end
