class AddRatingToQueueitems < ActiveRecord::Migration
  def change
    add_column :queue_items, :rating, :integer
  end
end
