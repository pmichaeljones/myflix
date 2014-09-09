require 'spec_helper'

describe Video do

  before do
    Category.new(name:"Horror").save
    @video = Video.new(title:"When Harry Met Sally", description:"A touching story.", category_id: 1)
  end

  it "can be saved" do
    @video.save
    expect(@video.valid?).to eq(true)
  end

  it { should belong_to(:category) }

  it { should validate_presence_of(:title)}

  it { should validate_presence_of(:description)}

end

