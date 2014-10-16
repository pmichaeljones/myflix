require 'spec_helper'

describe UsersController do
 # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  describe 'GET new_with_invitation_token' do

    it 'renders the :new view template' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it 'sets @user with the recipient email address' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email_address).to eq(invitation.recipient_email)
    end

    it 'redirects to expired token page for invalid tokens' do
      get :new_with_invitation_token, token: "12345"
      expect(response).to redirect_to expired_token_path
    end

    it 'sets the @invitation_token variable' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

  end

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

      it 'makes the user follower the inviter' do
        patrick = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: patrick, recipient_email: 'joe@example.com')
        post :create, user: {email_address: 'joe@example.com', password: "password", full_name: "Jonny"}, invitation_token: invitation.token
        joe = User.where(email_address: 'joe@example.com').first
        expect(joe.follows?(patrick)).to eq(true)
      end

      it 'makes the inviter follow the user' do
        patrick = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: patrick, recipient_email: 'joe@example.com')
        post :create, user: {email_address: 'joe@example.com', password: "password", full_name: "Jonny"}, invitation_token: invitation.token
        joe = User.where(email_address: 'joe@example.com').first
        expect(patrick.follows?(joe)).to eq(true)
      end

      it 'expires the invitation upon acceptance' do
        patrick = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: patrick, recipient_email: 'joe@example.com')
        post :create, user: {email_address: 'joe@example.com', password: "password", full_name: "Jonny"}, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
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
