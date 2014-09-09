require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name:"comedies")
    category.save

    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    dark_humor = Category.create(name:"Dark Humor")
    south_park = Video.create(title:"South Park", description:"Funny video", category: dark_humor)
    futurama = Video.create(title:"Futurama", description:"Space travel video", category: dark_humor)

    expect(dark_humor.videos).to eq([futurama, south_park])
  end


end
