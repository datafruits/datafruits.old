class MigratePodcastsToCarrierwave < ActiveRecord::Migration
  def change
    rename_column :podcasts, :mp3_file_name, :mp3
  end
end
