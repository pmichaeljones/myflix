require 'spec_helper'

describe UsersController do
 # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  describe 'GET show' do
    let(:bob){ Fabricate(:user) }

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: bob.id}
    end

    it 'sets @user to current user' do
      set_current_user(bob)

      get :show, id: bob.id
      expect(assigns(:user)).to eq(bob)
    end

    it 'renders show template' do
      set_current_user(bob)
      get :show, id: bob.id
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

    context 'sending emails' do

      after { ActionMailer::Base.deliveries.clear }

      it 'sends out email to the user with valid inputs' do
        post :create, user: { email_address: "bill@email.com", password: "password", full_name: "Bill Miller"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(["bill@email.com"])
      end

      it 'send out email containing user name with valid in puts' do
        post :create, user: { email_address: "bill@email.com", password: "password", full_name: "Bill Miller"}
        expect(ActionMailer::Base.deliveries.last.body).to include("Bill Miller")
      end

      it 'does not send out email with invalid inputs' do
        post :create, user: { password: "password", full_name: "Bill Miller"}
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

    end

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
