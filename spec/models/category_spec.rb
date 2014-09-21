require 'spec_helper'

describe Category do
  before do
    @humor = Category.create(name:"Humor")
    @horror = Category.create(name:"Horror")
    @forest_whitaker = Video.create(title:"Forest Whitaker", description: "Movie about Hope", category: @humor)
    @forest_gump = Video.create(title:"Forest Gump", description: "American Classic", category: @humor)
    @forest_hills = Video.create(title:"Forest Hills", description: "Nat Geo on Pine Trees", category: @humor)

  end

  it { should have_many(:videos)}

  it { should validate_presence_of(:name)}

  describe '#recent_videos' do

    it 'should return up to 6 videos' do
      7.times { video = Video.create(title:"Stuff", description: "Things", category: @humor) }
      expect(@humor.recent_videos.size).to eq(6)
    end

    it 'should only return the 6 most recent videos' do
      6.times { video = Video.create(title:"Stuff", description: "Things", category: @humor) }
      new_show = Video.create(title:"show", description: "horrible show", category: @humor, created_at: 1.day.ago)

      expect(@humor.recent_videos).not_to include(new_show)
    end


    it 'returns an empty array if the category does not have any videos' do
      expect(@horror.recent_videos).to eq([])
    end


    it 'should order them by newest videos (most recent "created_at") first' do
      expect(@humor.recent_videos).to eq([@forest_hills, @forest_gump, @forest_whitaker])
    end

  end


end
