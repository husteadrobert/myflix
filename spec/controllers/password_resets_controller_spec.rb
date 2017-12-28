require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid" do
      alice = Fabricate(:user)
      get :show, id: alice.token
      expect(response).to render_template :show
    end
    it "sets @token" do
      alice = Fabricate(:user)
      get :show, id: alice.token
      expect(assigns(:token)).to eq(alice.token)
    end
    it "redirects to the expired token page if the token is not valid" do
      alice = Fabricate(:user)
      get :show, id: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "should update user's password" do
        alice = Fabricate(:user, password: "old_password")
        post :create, token: alice.token, password: 'new_password'
        expect(alice.reload.authenticate('new_password')).to be_truthy
      end
      it "should redirect to the sign in page" do
        alice = Fabricate(:user, password: "old_password")
        post :create, token: alice.token, password: 'new_password'
        expect(response).to redirect_to login_path
      end
      it "sets the flash success message" do
        alice = Fabricate(:user, password: "old_password")
        post :create, token: alice.token, password: 'new_password'
        expect(flash[:success]).to be_present
      end
      it "regenerates the user token" do
        alice = Fabricate(:user, password: "old_password")
        alice.update_column(:token, "12345")
        post :create, token: alice.token, password: 'new_password'
        expect(alice.reload.token).to_not eq("12345")
      end
    end
    context "with invalid token" do
      it "redirects to the expired token path" do
        post :create, token: '12345', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end