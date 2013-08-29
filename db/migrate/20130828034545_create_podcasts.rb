class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :title
      t.integer :user_id
      t.attachment :mp3
      t.string :description

      t.timestamps
    end
  end
end
