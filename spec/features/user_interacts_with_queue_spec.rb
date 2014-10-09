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

    visit root_path
    find("a[href='/videos/#{anchorman.id}']").click
    click_link "+ My Queue"

    visit root_path
    find("a[href='/videos/#{superbad.id}']").click
    click_link "+ My Queue"

    # within(:xpath, "//tr[contains(.,'#{diehard.title}')]") do
    #   fill_in "queue_items[][position]", with: 3
    # end

    # within(:xpath, "//tr[contains(.,'#{anchorman.title}')]") do
    #   fill_in "queue_items[][position]", with: 1
    # end

    # within(:xpath, "//tr[contains(.,'#{superbad.title}')]") do
    #   fill_in "queue_items[][position]", with: 2
    # end

    find("input[data-video-id='#{diehard.id}']").set(3)
    find("input[data-video-id='#{anchorman.id}']").set(1)
    find("input[data-video-id='#{superbad.id}']").set(2)


    click_button "Update Instant Queue"

    expect(find("input[data-video-id='#{diehard.id}']").value).to eq("3")
    expect(find("input[data-video-id='#{anchorman.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{superbad.id}']").value).to eq("2")


  end

end
