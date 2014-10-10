require 'spec_helper'

describe User do

  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email_address) }
  it { should have_many(:queue_items).order('position') }

describe "#queued_video?" do
  it "returns true when user has queued the video" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    Fabricate(:queue_item, user: user, video: video)
    expect(user.queued_video?(video)).to eq(true)
  end

end

end
