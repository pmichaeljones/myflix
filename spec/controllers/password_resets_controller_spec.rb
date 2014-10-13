require 'spec_helper'

describe PasswordResetsController do

  describe "GET show" do
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

end
