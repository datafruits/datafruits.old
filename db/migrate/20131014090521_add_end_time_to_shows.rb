class AddEndTimeToShows < ActiveRecord::Migration
  def change
    add_column :shows, :end_time, :datetime
  end
end
