require 'spec_helper'

feature 'User signs in ' do

  background do
    User.make(:email_address => "p@jones.com", :password => "wally" )
  end


  scenario 'with existing username' do
    visit sign_in_path
    fill_in 'email', :with => "p@jones.com"
    fill_in 'password', :with => 'wally'
    click_button 'Sign in'

    page.should have_content("success")

  end
end
