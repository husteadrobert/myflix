require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "sets up a new @user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST create' do
    it "creates a new @user variable from form parameters" do
      #user = {name: "John Smith", email_address: "abc@123.com", password: "secret"}
      count = User.all.size
      post :create, user: Fabricate.attributes_for(:user)
      expect(User.count).to eq(count + 1)
    end
    it "redirects to login page after saving" do
      user = {name: "John Smith", email_address: "abc@123.com", password: "secret"}
      post :create, user: user
      expect(response).to redirect_to login_path
    end
    it "does not redirect if @user is invalid" do
      user = {name: ""}
      post :create, user: user
      expect(response).to_not redirect_to login_path
    end
    it "renders the new template if invalid" do
      user = {name: ""}
      post :create, user: user
      expect(response).to render_template "new"
    end
    it "sets up @user variable" do
      user = {name: "What"}
      post :create, user: user
      expect(assigns(:user).name).to eq("What")
    end
  end
end