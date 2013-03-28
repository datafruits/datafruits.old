class Show < ActiveRecord::Base
  attr_accessible :time, :title, :user_id

  belongs_to :user

  validates_presence_of :time,:title,:user_id

  def start_time
    time
  end
end
