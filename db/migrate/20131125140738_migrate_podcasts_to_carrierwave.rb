class MigratePodcastsToCarrierwave < ActiveRecord::Migration
  def change
    remove_attachment :podcasts, :mp3
    add_column :podcasts, :mp3, :string
  end
end
