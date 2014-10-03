require 'spec_helper'

describe QueueItemsController do

  describe 'DELETE destroy' do

    it 'should redirect to my queue page' do
      bob = Fabricate(:user)
      jim = Fabricate(:user)
      queue_item = Fabricate(:queue_item)
      session[:user_id] = jim.id
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it 'deletes the queue item' do
      bob = Fabricate(:user)
      jim = Fabricate(:user)
      diehard = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: jim, video: diehard)
      session[:user_id] = jim.id
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it 'should does not delete queue item if current user does not own queue item' do
      bob = Fabricate(:user)
      jim = Fabricate(:user)
      diehard = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: jim, video: diehard)
      session[:user_id] = bob.id
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end


    it 'redirects to signin page for unauthenticated users' do
      delete :destroy, id: 1
      expect(response).to redirect_to sign_in_path
    end

    it 'normalizes the positions of remaining queue' do
      bob = Fabricate(:user)
      jim = Fabricate(:user)
      queue_item = Fabricate(:queue_item, position: 1, user: bob)
      queue_item2 = Fabricate(:queue_item, position: 3, user: bob)
      session[:user_id] = bob.id
      delete :destroy, id: queue_item.id
      expect(QueueItem.first.position).to eq(1)
    end

  end


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

  describe 'POST update_queue' do

    context 'with valid inputs' do
      let(:bob) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: bob, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: bob, position: 2, video: video) }

      before do
        session[:user_id] = bob.id
      end

      it 'redirects to the my queue page' do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, postion: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it 'reorders the queue items' do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(bob.queue_items).to eq([queue_item2, queue_item1])

      end

      it 'normalizes the position number' do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(bob.queue_items.map(&:position)).to eq([1, 2])
      end

    end

    context 'with invalid inputs' do
      let(:bob) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, position: 1, user: bob, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: bob, video: video) }

      it 'redirects to the my queue page' do
        session[:user_id] = bob.id
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end

      it 'sets the flash error message' do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]

        expect(flash[:danger]).to be_present
      end

      it 'does not change the queue items' do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end

    end

    context 'with unauthenticated user' do
      it 'should redirect to sign_in path' do
        post :update_queue, queue_items:
        [{id: 1, position: 3},
        {id: 2, position: 2.1}]
        expect(response).to redirect_to sign_in_path
      end

    end

    context 'with queue items that do not below to current user' do

      it 'does not change the queue item' do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        phil = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: phil, position: 1)
        post :update_queue, queue_items:[{id: queue_item1.id, position: 2}]

        expect(queue_item1.reload.position).to eq(1)
      end

    end


  end



end
