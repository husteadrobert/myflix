require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with blank input" do
      it "redirects to the forgot password page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      it "shows an error message" do
        post :create, email: ''
        expect(flash[:error]).to eq("Email cannot be blank.")
      end
    end
    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        alice = Fabricate(:user)
        post :create, email: alice.email_address
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it "sends out an email to the email address" do
        alice = Fabricate(:user)
        post :create, email: alice.email_address
        expect(ActionMailer::Base.deliveries.last.to.first).to eq(alice.email_address)
      end
    end
    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, email: "lolno@what.com"
        expect(response).to redirect_to forgot_password_path
      end
      it "shows an error message" do
        post :create, email: "lolno@what.com"
        expect(flash[:error]).to eq("Email address not in system")
      end
    end
  end
end