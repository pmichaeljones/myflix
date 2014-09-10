require 'spec_helper'

describe Video do

  it { should belong_to(:category) }

  it { should validate_presence_of(:title)}

  it { should validate_presence_of(:description)}

  it "should have a class method called search_by_title" do
    expect(Video.respond_to?(:search_by_title)).to eq(true)
  end


end

describe "#search_by_title" do

  it "should return 'south park' when searching for 'south' " do
    south_park = Video.create(title:"South Park", description: "Funny movie")
    expect(Video.search_by_title("south")).to include south_park
  end


  it "should return an empty array when searching for 'dogs' " do
    expect(Video.search_by_title("dogs")).to be_empty
  end


end
