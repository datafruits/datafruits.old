class Show < ActiveRecord::Base
  attr_accessible :time, :title, :user_id

  belongs_to :user
end
