require 'spec_helper'

describe RelationshipsController do

  describe 'GET index' do

    it 'sets @relationships to the current users following relationships' do
      bob = Fabricate(:user)
      set_current_user(bob)
      john = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)

      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

  end


end
