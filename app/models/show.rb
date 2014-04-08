class Show < ActiveRecord::Base

  belongs_to :user
  has_attached_file :image,
    styles: { :thumb => "x120" },
    :path => "/:style/:filename",
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
