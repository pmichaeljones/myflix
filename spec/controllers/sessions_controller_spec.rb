require 'spec_helper'

describe SessionsController do

  describe 'GET new' do

    it 'redirects to :root for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to root_path
    end

    it 'renders the :new template for unauthenticated users' do
      get :new
      expect(response).to render_template :new
    end

  end
# # # # #
  describe 'POST create' do

    it 'should find the user by their email address' do
      user = Fabricate(:user)
      post :create, attributes: user.attributes

      new_user = User.where(email_address: user.email_address).first
      expect(new_user).to eq(user)
    end

    context 'with valid credentials' do

      before do
        jimbo = Fabricate(:user)
        post :create, email: jimbo.email_address, password: jimbo.password
      end

      it 'should assign session[:user_id] to the user id' do
        expect(session[:user_id]).not_to be_nil
      end

      it 'should set the flash[:info]' do
        expect(flash[:info]).not_to be_blank
      end

      it 'should redirect to video path on success' do
        expect(response).to redirect_to videos_path
      end

    end

    context 'with invalid credentials' do

      before do
        jimbo = Fabricate(:user)
        post :create, password: jimbo.password + "12345", email: jimbo.email_address
      end

      it 'should not set the session[:user_id]' do
        expect(session[:user_id]).to be_blank
      end


      it 'should render the new template' do
        expect(response).to render_template :new
      end

      it 'should set the flash[:danger]' do
        expect(flash[:danger]).not_to be_blank
      end

    end

  end
# # # #
  describe 'GET destroy' do

    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end


    it 'should set the session[:user_id] to nil' do
      expect(session[:user_id]).to eq(nil)
    end

    it 'should redirect to root' do
      expect(response).to redirect_to root_path
    end

  end

end
