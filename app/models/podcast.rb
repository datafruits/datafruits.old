class Podcast < ActiveRecord::Base
  belongs_to :user
  has_attached_file :mp3,
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    },
    bucket: 'datafruits.fm',
    path: '/:filename',
    preserve_files: true
  validates_attachment_presence :mp3
  validates_presence_of :pub_date

  def set_file_as_attachment file
    s3 = AWS::S3.new
    obj = s3.buckets['datafruits.fm'].objects["#{file}"]
    puts obj
    self.mp3_file_name    = file
    self.mp3_content_type = MIME::Types.type_for(self.mp3_file_name).first.to_s
    #self.mp3_file_size    = obj.content_length
    self.mp3_updated_at   = Time.now
    puts "saving"
    self.save!
  end
end
