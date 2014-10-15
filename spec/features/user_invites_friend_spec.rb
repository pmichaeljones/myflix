require 'spec_helper'

feature 'User invites friend' do

  scenario 'user successfully invites friend and invitiation is accepted' do
    patrick = Fabricate(:user)
    sign_in(patrick)

    visit new_invitation_path

    fill_in "Friend's Name", with: "Mitch Salm"
    fill_in "Friend's Email Address", with: "mitch@salm.com"
    fill_in "Message", with: "hey buddy!"
    click_button "Send Invitation"

    open_email "mitch@salm.com"
    current_email.click_link "Accept This Invitation"



  end


end
