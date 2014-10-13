require 'spec_helper'

describe ForgotPasswordsController do

  describe 'POST create' do

    context 'with blank input' do
      it 'redirects to the forgot passwords page' do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end

      it 'shows an error message' do
        post :create, email: ""
        expect(flash[:danger]).to eq("E-mail cannot be blank.")
      end

    end


    context 'with existing email' do
      it 'redirects to the forgot password confirmation page' do
        Fabricate(:user, email_address: "bill@example.com")
        post :create, email: 'bill@example.com'
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it 'sends out an email to the email address' do
        Fabricate(:user, email_address: "bill@example.com")
        post :create, email: 'bill@example.com'
        expect(ActionMailer::Base.deliveries.last.to).to eq(["bill@example.com"])
      end

    end

    context 'with non-existent email' do
      it 'redirects to forgot password page' do
        post :create, email: 'bill@example.com'
        expect(response).to redirect_to forgot_password_path
      end

      it 'shows a flash error message' do
        post :create, email: "bill@example.com"
        expect(flash[:danger]).to eq("We do not have that email in our system.")
      end

    end

  end

end
