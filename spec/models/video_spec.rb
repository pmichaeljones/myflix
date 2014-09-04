require 'spec_helper'

describe Video do

  before do
    Category.new(name:"Horror").save
    @video = Video.new(title:"When Harry Met Sally", description:"A touching story.", category_id: 1)
  end

  it "has a title" do
    expect(@video.title).to eq("When Harry Met Sally")
  end

  it "can be saved" do
    @video.save
    expect(@video.valid?).to eq(true)
  end

  it "can belong to a category" do
    expect(@video.category.name).to eq("Horror")
  end

end

