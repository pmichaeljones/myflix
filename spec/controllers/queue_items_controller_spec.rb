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
  end

    it 'redirects to the sign in page for unauthenticated user' do
      get :index
      expect(response).to redirect_to sign_in_path
    end


end
