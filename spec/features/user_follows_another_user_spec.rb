require 'spec_helper'

feature 'user follows another user' do

  scenario 'user follows user, confirms following status, and then unfollows, confirming status' do
    bob = Fabricate(:user)
    jim = Fabricate(:user)

    sign_in(bob)

    visit_user_profile(jim)

    click_link("Follow User")

    verify_follow_status(bob, jim)

    remove_follow_relationships

    verify_unfollow_status(bob, jim)

  end

  def visit_user_profile(other_user)
    visit("/users/#{other_user.id}")
  end

  def verify_follow_status(user1, user2)
  end

  def remove_follow_relationships
  end

  def verify_unfollow_status(user1, user2)
  end


end
