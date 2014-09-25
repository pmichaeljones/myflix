class ChangeUseridStringToInteger < ActiveRecord::Migration
  def change
    change_column :reviews, :user_id, :integer
  end
end
