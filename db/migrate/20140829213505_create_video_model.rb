class CreateVideoModel < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :small_image_url, :big_image_url, :title
      t.text :description
      t.timestamps

    end
  end
end
