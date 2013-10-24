class AddAdditionalFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :likes, :text
    add_column :users, :hates, :text
    add_column :users, :favorite_food, :text
    add_column :users, :style, :text
  end
end
