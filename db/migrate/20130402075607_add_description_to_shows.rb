class AddDescriptionToShows < ActiveRecord::Migration
  def change
    add_column :shows, :shows, :text
  end
end
