class AddMp3UrlToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :mp3_url, :string
  end
end
