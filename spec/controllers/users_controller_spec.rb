require 'spec_helper'

describe UsersController do
 # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  describe 'Get show' do

    it 'sets @user to current user' do
      bob = Fabricate(:user)

      get :show, params: {user_id: bob.id}
      expect(assigns(:user)).to eq(bob)
    end


    it 'renders show template' do
      get :show
      expect(response).to render_template :show
    end


  end
 # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  describe 'GET new' do

    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end

  end
 # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  describe 'POST create' do

    context 'with valid input' do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to sign_in_path
      end

    end

    context 'with invalid input' do

      before do
        post :create, user: {password: '12345', full_name: 'Patrick Jones'}
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end

      it 'does not create user' do
        expect(User.count).to eq(0)
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end

    end
  end
end
