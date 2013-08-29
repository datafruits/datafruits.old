class AddPubDateToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :pub_date, :datetime
  end
end
