class Post < ActiveRecord::Base
  attr_accessible :body, :title, :image

  has_attached_file :image, styles: { :thumb => "260x" },
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    },
    bucket: 'datafruits.fm'

  validates_presence_of :title,:body


  def summary
    body.split("READMORE").first
  end
end
