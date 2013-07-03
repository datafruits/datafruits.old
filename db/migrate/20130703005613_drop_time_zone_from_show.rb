class DropTimeZoneFromShow < ActiveRecord::Migration
  def change
    remove_column :shows, :time_zone  
  end
end
