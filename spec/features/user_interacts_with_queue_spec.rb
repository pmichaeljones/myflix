require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders video in the queue" do

    comedies = Fabricate(:category, name: "Comedies")
    diehard = Fabricate(:video, title: "Diehard", category: comedies)
    anchorman = Fabricate(:video, title: "Anchorman", category: comedies)
    superbad = Fabricate(:video, title: "SuperBad", category: comedies)

    sign_in

    find("a[href='/videos/#{diehard.id}']").click
    page.should have_content(diehard.title)

    click_link "+ My Queue"
    page.should have_content(diehard.title)

    visit video_path(diehard)
    page.should_not have_content("+ My Queue")

  end

end
