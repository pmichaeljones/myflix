require 'spec_helper'

describe QueueItemsController do

  describe 'GET index' do
    it 'sets @queue_items to the queue items of the logged-in user' do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      qi1 = Fabricate(:queue_item, user: bob)
      qi2 = Fabricate(:queue_item, user: bob)

      get :index
      expect(assigns(:queue_items)).to match_array([qi1, qi2])
    end

    it 'redirects to the sign in page for unauthenticated user' do
      get :index
      expect(response).to redirect_to sign_in_path
    end

  end

  describe 'POST create' do

    context 'with valid inputs' do
      let(:diehard) {Fabricate(:video)}
      let(:jim) {Fabricate(:user)}

      before do
        session[:user_id] = jim.id
      end

      it 'redirects to the my queue page' do
        post :create, video_id: diehard.id
        expect(response).to redirect_to my_queue_path
      end

      it 'creates a queue item' do
        post :create, video_id: diehard.id
        expect(QueueItem.count).to eq(1)
      end

      it 'creates a queue item that is associated with the video' do
        post :create, video_id: diehard.id
        expect(QueueItem.first.video).to eq(diehard)
      end


      it 'creates a queue item that is associated with signed in user' do
        post :create, video_id: diehard.id
        expect(QueueItem.first.user).to eq(jim)
      end

      it 'puts the video as the last one in the queue' do
        Fabricate(:queue_item, video: diehard, user: jim)
        rambo = Fabricate(:video)
        post :create, video_id: rambo.id
        rambo_queue_item = QueueItem.where(video_id: rambo.id, user_id: jim.id).first
        expect(rambo_queue_item.position).to eq(2)
      end

      it 'does not add the video to the queue if video is already there' do
        Fabricate(:queue_item, video: diehard, user: jim)
        post :create, video_id: diehard.id
        expect(QueueItem.count).to eq(1)
      end


      it 'redirects to the signin page for unauth users' do
        session[:user_id] = nil
        post :create, video_id: 3
        expect(response).to redirect_to sign_in_path
      end


    end

  end


end
