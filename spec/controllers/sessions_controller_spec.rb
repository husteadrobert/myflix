require 'spec_helper'

describe SessionsController do
  let(:user) { Fabricate(:user) }

  describe "GET new" do
    it "redirects to home page if already logged in" do
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to home_path
    end
    it "renders the new page if not logged in" do
      get :new
      expect(response).to render_template "new"
    end
  end

  describe "POST create" do
    it "redirects to the home page if login credentials are correct" do
      post :create, email_address: user.email_address, password: user.password
      expect(response).to redirect_to home_path
    end
    it "sets the current session[:user_id] to the users ID" do
      post :create, email_address: user.email_address, password: user.password
      expect(session[:user_id]).to eq(user.id)
    end
    it "does not redirect to the home page if login credentials are incorrect" do
      post :create, email_address: user.email_address, password: "NOPE!"
      expect(response).not_to redirect_to home_path
    end
  end

  describe "GET destroy" do
    it "sets the session[:user_id] to nil" do
      post :create, email_address: user.email_address, password: user.password
      expect(session[:user_id]).to eq(user.id)
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end
    it "redirects back to the root path" do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end