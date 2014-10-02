require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_title" do

    it 'returns the title of the associated video' do
      video = Fabricate(:video, title: "Monk")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end

  end

  describe "#rating" do

    it 'should return the rating of the associated video when present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(4)
    end

    it 'returns nil when a view is not present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category_name" do

    it 'should return the category name of the associated video' do
      category = Fabricate(:category, name: "Baller!")
      video = Fabricate(:video, category: category)
      qi = Fabricate(:queue_item, video: video)
      expect(qi.category_name).to eq("Baller!")
    end

  end

  describe "#category" do

    it 'should return the the category object for the associated video' do
      category = Fabricate(:category, name: "Baller!")
      video = Fabricate(:video, category: category)
      qi = Fabricate(:queue_item, video: video)
      expect(qi.category).to eq(category)
    end
  end


end
