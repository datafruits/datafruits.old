class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => "false", :default => ""

      t.timestamps
    end
  end
end
