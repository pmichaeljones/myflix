require 'spec_helper'

describe User do

  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email_address) }
  it { should have_many(:queue_items).order('position') }
  it { should have_many(:reviews).order("created_at DESC") }

  describe "#queued_video?" do
    it "returns true when user has queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to eq(true)
    end
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with the other user" do
      bob = Fabricate(:user)
      jim = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: jim, follower: bob)
      expect(bob.follows?(jim)).to eq(true)
    end

    it "returns false if the user does not have a following relationship with the other user" do
      bob = Fabricate(:user)
      jim = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: jim)
      expect(bob.follows?(jim)).to eq(false)
    end

  end
end
