class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, :email_address, :password_digest
      t.timestamps
    end
  end
end
