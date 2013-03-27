class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.integer :user_id
      t.datetime :time

      t.timestamps
    end
  end
end
