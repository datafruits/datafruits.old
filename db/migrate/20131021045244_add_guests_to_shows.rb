class AddGuestsToShows < ActiveRecord::Migration
  def change
    add_column :shows, :guests, :text
  end
end
