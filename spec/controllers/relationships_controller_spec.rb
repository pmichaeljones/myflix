require 'spec_helper'

describe RelationshipsController do

  describe 'POST create' do

    it_behaves_like 'requires sign in' do
      let(:action) { post :create, id: 3}
    end

    it 'creates relationship between current_user and leader'

    it 'redirects to followers page for current user'

  end

  describe 'DELETE destroy' do

    it_behaves_like 'requires sign in' do
      let(:action) { delete :destroy, id: 5}
    end

    it 'deletes the relationships if the current user is the follower' do
      bob = Fabricate(:user)
      set_current_user(bob)
      john = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: john)

      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end

    it 'does not delete the relationship if the current user is not a follower' do
      bob = Fabricate(:user)
      pete = Fabricate(:user)
      set_current_user(bob)
      john = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: pete, leader: john)

      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end

    it 'redirects to the people page' do
      bob = Fabricate(:user)
      set_current_user(bob)
      john = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: john)

      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end


  end

  describe 'GET index' do

    it 'sets @relationships to the current users following relationships' do
      bob = Fabricate(:user)
      set_current_user(bob)
      john = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: john)

      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action){ get :index }
    end

  end


end
