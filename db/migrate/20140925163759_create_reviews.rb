class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :author
      t.text :body
      t.integer :video_id, :rating
      t.timestamps
    end
  end
end
