require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders video in the queue" do

    comedies = Fabricate(:category, name: "Comedies")
    diehard = Fabricate(:video, title: "Diehard", category: comedies)
    anchorman = Fabricate(:video, title: "Anchorman", category: comedies)
    superbad = Fabricate(:video, title: "SuperBad", category: comedies)

    sign_in

    find_video_and_add_to_queue(diehard)

    click_link "+ My Queue"
    queue_should_contain(diehard)



    visit video_path(diehard)
    page.should_not have_content("+ My Queue")

    add_video_to_queue(anchorman)
    add_video_to_queue(superbad)

    # will learn xpath in the future. Commented out for now.
    # within(:xpath, "//tr[contains(.,'#{diehard.title}')]") do
    #   fill_in "queue_items[][position]", with: 3
    # end

    # within(:xpath, "//tr[contains(.,'#{anchorman.title}')]") do
    #   fill_in "queue_items[][position]", with: 1
    # end

    # within(:xpath, "//tr[contains(.,'#{superbad.title}')]") do
    #   fill_in "queue_items[][position]", with: 2
    # end

    find_video_and_set_new_position(diehard, 3)
    find_video_and_set_new_position(anchorman, 1)
    find_video_and_set_new_position(superbad, 2)

    click_button "Update Instant Queue"

    expect_video_location(diehard, 3)
    expect_video_location(anchorman, 1)
    expect_video_location(superbad, 2)

  end

  def queue_should_contain(video)
    page.should have_content(video.title)
  end

  def find_video_and_add_to_queue(video)
    find("a[href='/videos/#{video.id}']").click
    page.should have_content(video.title)
  end

  def find_video_and_set_new_position(video, position)
    find("input[data-video-id='#{video.id}']").set(position)
  end

  def add_video_to_queue(video)
    visit root_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def expect_video_location(video, position)
    expect(find("input[data-video-id='#{video.id}']").value).to eq(position.to_s)
  end

end
