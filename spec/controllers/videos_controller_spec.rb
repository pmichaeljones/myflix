require 'spec_helper'

describe VideosController do

  describe "GET show" do

    it "sets @video if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirect the user to the sign-up page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end

    it 'should set the @review variable for authenticated' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:review)).to be_instance_of(Review)
    end


    it 'should set the @reviews variable' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:reviews)).to eq(Review.all)
    end


  end #ends GET show

  describe "GET search" do

    it "sets the @results variable for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Video.create(title:"Gone with the wind", description: "Sad story")
      get :search, input: "one"
      expect(assigns(:results)).to include video
    end

    it "redirect unauthenticated user to sign in path" do
      video = Fabricate(:video, title:"Gone with the wind")
      get :search, input: "one"
      expect(response).to redirect_to sign_in_path
    end

    it "renders the results template instead of search template" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video, title:"Gone with the wind")
      get :search, input: "one"
      expect(response).to render_template :results
    end

  end #ends 'GET search'
end #ends VideosController