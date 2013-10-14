class Show < ActiveRecord::Base

  belongs_to :user
  has_attached_file :image,
    styles: { :thumb => "x120" },
    storage: :s3,
    :path => "/:style/:filename",
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    },
    bucket: 'datafruits.fm',
    preserve_files: true

  validates_presence_of :time,:user_id
  validate :schedule_cannot_conflict

  def start_time
    time
  end

  def schedule_cannot_conflict
    Show.where.not(id: id).each do |show|
      if end_time > show.time && time < show.end_time
        errors.add(:time, " conflict detected with show '#{show.user.username} - #{show.title}'. Please choose a different time.")
      end
    end
  end
end
