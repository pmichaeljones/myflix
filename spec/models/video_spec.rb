require 'spec_helper'

describe Video do

  before do
    @video = Video.new(title:"When Harry Met Sally", description:"A touching story.")
  end

  it "has a title" do
    expect(@video.title).to eq("When Harry Met Sally")
  end

  it "can be saved" do
    @video.save
    expect(@video.valid?).to eq(true)
  end


end

