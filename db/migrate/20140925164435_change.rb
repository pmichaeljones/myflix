class Change < ActiveRecord::Migration
  def change
    rename_column :reviews, :author, :user_id
  end
end
