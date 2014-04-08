class Advert < ActiveRecord::Base
  has_attached_file :mp3,
    path: ':filename',
    preserve_files: true
end
