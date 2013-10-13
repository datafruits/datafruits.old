class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string "title"
      t.attachment :mp3

      t.timestamps
    end
  end
end
