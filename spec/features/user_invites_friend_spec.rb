require 'spec_helper'

feature 'User invites friend' do

  scenario 'user successfully invites friend and invitiation is accepted' do

    patrick = Fabricate(:user)
    sign_in(patrick)

    visit new_invitation_path
    fill_in "invitation_recipient_name", with: "Mitch"
    fill_in "invitation_recipient_email", with: "mitch@salm.com"
    fill_in "invitation_message", with: "hey buddy! Join this site!"
    click_button('Send Invitation')
    sign_out

    open_email("mitch@salm.com")
    current_email.click_link("Accept This Invitation")

    fill_in "user_password", with: "password"
    fill_in "user_full_name", with: "Mitch Salm"

    click_button "Sign Up"

    fill_in "email", with: "mitch@salm.com"
    fill_in "password", with: "password"
    click_button "Sign in"

    click_link "People"
    expect(page).to have_content "#{patrick.full_name}"

    sign_out

    sign_in(patrick)
    click_link "People"
    expect(page).to have_content "Mitch Salm"

    clear_emails

  end


end
