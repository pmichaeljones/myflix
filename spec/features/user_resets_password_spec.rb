require 'spec_helper'

feature 'User resets password' do

  scenario 'user successfully resets the password' do
    patrick = Fabricate(:user, password: 'old_password')

    visit sign_in_path
    click_link 'Forgot Password?'
    fill_in "Email Address", with: patrick.email_address
    click_button "Send Email"

    open_email(patrick.email_address)
    current_email.click_link"Reset Password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "email", with: patrick.email_address
    fill_in "password", with: "new_password"
    click_button "Sign in"

    expect(page).to have_content("Welcome, #{patrick.full_name}")

  end

end
