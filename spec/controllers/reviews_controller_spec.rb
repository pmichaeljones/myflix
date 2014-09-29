require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video){ Fabricate(:video) }

    context "with unauthenticated users" do
      it 'should redirec to sign in path' do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to sign_in_path
      end

    end

    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end

      context "with valid inputs" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it 'creates a review' do
          expect(Review.count).to eq(1)
        end

        it 'creates the review associated with the video' do
          expect(Review.first.video).to eq(video)
        end

        it 'creates a review associated with the signed in user' do
          video = Fabricate(:video)

          expect(Review.first.user).to eq(current_user)
        end

        it 'redirects to the video show page' do
          expect(response).to redirect_to video
        end

      end

      context "with invalid inputs" do
        it "does not create a review" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(Review.count).to eq(0)
        end

        it "sets @video" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end


        it "sets @reviews" do
          review2 = Fabricate(:review, video_id: video.id)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:reviews)).to eq(video.reviews)
        end


        it "renders the videos/show template" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(response).to render_template "videos/show"
        end


      end

    end

  end


end
