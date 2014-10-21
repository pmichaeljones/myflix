require 'spec_helper'

describe Video do

  before do
    @forest_whitaker = Video.create(title:"Forest Whitaker", description: "Movie about Hope")
    @forest_gump = Video.create(title:"Forest Gump", description: "American Classic")
    @forest_hills = Video.create(title:"Forest Hills", description: "Nat Geo on Pine Trees")

  end


  it { should belong_to(:category) }

  it { should have_many(:reviews).order("created_at DESC") }

  it { should validate_presence_of(:title)}

  it { should validate_presence_of(:description)}

  it "should have a class method called search_by_title" do
    expect(Video.respond_to?(:search_by_title)).to eq(true)
  end

  describe "#search_by_title" do

  it "should return array with multiple items for partial match" do
    expect(Video.search_by_title("Forest")).to include @forest_gump, @forest_whitaker, @forest_hills
  end

  it "should return an array of 1 video for a exact match" do
    expect(Video.search_by_title("Forest Gump")).to include @forest_gump
  end

  it "should return an array of all matches ordered by created_at" do
    expect(Video.search_by_title("Forest")).to include(@forest_whitaker, @forest_gump, @forest_hills)
  end

  it "should return an empty array when searching for 'dogs' " do
    expect(Video.search_by_title("dogs")).to eq([])
  end

  it "returns nothing for an empty string search" do
    expect(Video.search_by_title("")).to eq([])
  end

end


end


