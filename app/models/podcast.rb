class Podcast < ActiveRecord::Base
  belongs_to :user
  mount_uploader :mp3, Mp3Uploader
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

  def username
    user.username
  end
end
