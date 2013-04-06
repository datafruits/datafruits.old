class AddTimeZoneToShows < ActiveRecord::Migration
  def change
    add_column :shows, :time_zone, :string
  end
end
