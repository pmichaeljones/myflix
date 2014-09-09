require 'spec_helper'

describe Video do

  before do
    Category.new(name:"Horror").save
    @video = Video.new(title:"When Harry Met Sally", description:"A touching story.", category_id: 1)
  end

  it "requires a title" do
    harry = Video.create(title: nil, description:"A touching story.", category_id: 1)
    expect(harry.errors.full_messages[0]).to eq("Title can't be blank")
  end

  it "requires a description" do
    harry = Video.create(title:"When Harry Met Sally", description: nil, category_id: 1)
    expect(harry.errors.full_messages[0]).to eq("Description can't be blank")
  end


  it "can be saved" do
    @video.save
    expect(@video.valid?).to eq(true)
  end

  it "can belong to a category" do
    expect(@video.category.name).to eq("Horror")
  end

end

