class AddPubDateToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :pub_date, :datetime unless Podcast.column_names.include?("pub_date")
  end
end
