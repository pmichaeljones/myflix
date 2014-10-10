require 'spec_helper'

describe RelationshipsController do

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
