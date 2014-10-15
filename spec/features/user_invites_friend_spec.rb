require 'spec_helper'

feature 'User invites friend' do

  scenario 'user successfully invites friend and invitiation is accepted' do

    patrick = Fabricate(:user)

    sign_in(patrick)

    invite_friend
    friend_accepts_invite

    friend_signs_up

    friend_signs_in

    friend_verifies_follow(patrick)

    sign_in(patrick)

    click_link "People"
    expect(page).to have_content "Mitch"

    clear_emails

  end

  def invite_friend
    visit new_invitation_path
    fill_in "invitation_recipient_name", with: "Mitch"
    fill_in "invitation_recipient_email", with: "mitch@salm.com"
    fill_in "invitation_message", with: "hey buddy! Join this site!"
    click_button('Send Invitation')
    sign_out
  end

  def friend_accepts_invite
    open_email("mitch@salm.com")
    current_email.click_link("Accept This Invitation")
  end

  def friend_signs_up
    fill_in "user_password", with: "password"
    fill_in "user_full_name", with: "Mitch Salm"
    click_button "Sign Up"
  end

  def friend_signs_in
    fill_in "email", with: "mitch@salm.com"
    fill_in "password", with: "password"
    click_button "Sign in"
  end

  def friend_verifies_follow(other_friend)
    click_link "People"
    expect(page).to have_content "#{other_friend.full_name}"
    sign_out
  end


end
