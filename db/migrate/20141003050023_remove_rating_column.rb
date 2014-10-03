class RemoveRatingColumn < ActiveRecord::Migration
  def change
    remove_column :queue_items, :rating
  end
end
