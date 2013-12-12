class AddMp3UrlToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :mp3_url, :string
  end
end
