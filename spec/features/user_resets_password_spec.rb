require 'spec_helper'

feature 'User resets password' do

  scenario 'user successfully resets the password' do
    patrick = Fabricate(:user, password: 'old_password')

    visit sign_in_path
    click_link 'Forgot Password'
    fill_in "Email Address", with: patrick.email_address
    click_button "Send Email"

  end

end
