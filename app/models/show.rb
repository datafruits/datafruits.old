class Show < ActiveRecord::Base
  #attr_accessible :time, :title, :user_id, :description, :time_zone, :image

  belongs_to :user
  has_attached_file :image,
    styles: { :thumb => "x120" },
    storage: :s3,
    :path => "/:style/:filename",
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    },
    bucket: 'datafruits.fm'

  validates_presence_of :time,:user_id

  def start_time
    time
  end
end
