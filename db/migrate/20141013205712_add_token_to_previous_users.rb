class AddTokenToPreviousUsers < ActiveRecord::Migration
  def change
    User.all.each do |u|
      u.update_column(:token, SecureRandom.urlsafe_base64)
    end

  end
end
