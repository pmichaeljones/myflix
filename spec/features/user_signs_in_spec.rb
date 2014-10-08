require 'spec_helper'

feature 'User signs in' do
  let(:bob){ Fabricate(:user) }

  scenario 'with correct email' do
    visit sign_in_path
    fill_in 'email', :with => bob.email_address
    fill_in 'password', :with => bob.password
    click_button 'Sign in'

    page.should have_content bob.full_name
  end

  scenario 'with incorrect password' do
      visit sign_in_path
      fill_in 'email', :with => bob.email_address
      fill_in 'password', :with => 'wally'
      click_button 'Sign in'

      page.should have_content("Your username or password was wrong.")
  end

  scenario 'with incorrect email' do
      visit sign_in_path
      fill_in 'email', :with => "bob@bob.com"
      fill_in 'password', :with => bob.password
      click_button 'Sign in'

      page.should have_content("Your username or password was wrong.")
  end

end

