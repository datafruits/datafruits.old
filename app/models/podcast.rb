class Podcast < ActiveRecord::Base
  belongs_to :user
  has_attached_file :mp3,
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    },
    bucket: 'datafruits.fm'
end
