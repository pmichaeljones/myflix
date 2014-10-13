require 'spec_helper'

describe PasswordResetsController do

  describe "GET show" do

    it 'sets @token' do
      bob = Fabricate(:user)
      bob.update_column(:token, "12345")
      get :show, id: '12345'
      expect(assigns(:token)).to eq("12345")
    end

    it 'renders show template if the token is valid' do
      bob = Fabricate(:user)
      bob.update_column(:token, "12345")
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it 'redirects to expired token page if token is invalid' do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end

  end

  describe 'POST create' do

    context "with valid token" do

      it 'should redirect to signin page' do
        bob = Fabricate(:user, password: 'old_password')
        bob.update_column(:token, "12345")
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end

      it 'should update user password' do
        bob = Fabricate(:user, password: 'old_password')
        bob.update_column(:token, "12345")
        post :create, token: '12345', password: 'new_password'
        expect(bob.reload.authenticate('new_password')).to eq(bob)
      end

      it 'sets flash message to success' do
        bob = Fabricate(:user, password: 'old_password')
        bob.update_column(:token, "12345")
        post :create, token: '12345', password: 'new_password'
        expect(flash[:info]).to eq("Password Changed.")
      end


      it 'regenerates the user token' do
        bob = Fabricate(:user, password: 'old_password')
        bob.update_column(:token, "12345")
        post :create, token: '12345', password: 'new_password'
        expect(bob.reload.token).not_to eq("12345")
      end

    end

    context "with invalid token" do

      it 'redirects to the expired token path' do
        post :create, token: '12345', password: 'some password'
        expect(response).to redirect_to expired_token_path
      end

    end


  end

end
