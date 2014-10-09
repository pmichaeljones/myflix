require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders video in the queue" do
    diehard = Fabricate(:video, title: "Diehard")
    anchorman = Fabricate(:video, title: "Anchorman")
    superbad = Fabricate(:video, title: "SuperBad")
  end

end
