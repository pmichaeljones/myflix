require 'spec_helper'

feature 'User signs in ' do

  scenario 'with existing username' do
    visit sign_in_path
    fill_in 'Email', :with => "p@jones.com"
    fill_in 'Password', :with => 'wally'

    page.should have_content("success")

  end
end
