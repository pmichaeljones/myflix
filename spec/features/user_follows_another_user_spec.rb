require 'spec_helper'

feature 'user follows another user' do

  scenario 'user follows user, confirms following status, and then unfollows, confirming status' do
    bob = Fabricate(:user)
    jim = Fabricate(:user)

    sign_in(bob)

    visit_user_profile(jim)

    click_link("Follow User")

    verify_follow_status(jim)

    remove_follow_relationships

    verify_unfollow_status(jim)

  end

  def visit_user_profile(other_user)
    visit("/users/#{other_user.id}")
  end

  def verify_follow_status(leader)
    page.should have_content("#{leader.full_name}")
  end

  def remove_follow_relationships
    find('a[data-method="delete"]').click
  end

  def verify_unfollow_status(leader)
    page.should_not have_content("#{leader.full_name}")
  end


end
