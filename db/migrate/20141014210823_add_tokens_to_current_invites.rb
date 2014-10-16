class AddTokensToCurrentInvites < ActiveRecord::Migration
  def change
    Invitation.all.each do |u|
      u.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
