require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "sets up a new @user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST create' do
    after { ActionMailer::Base.deliveries.clear }
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

    it "makes the user follow the inviter" do
      alice = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
      post :create, user: Fabricate.attributes_for(:user, email_address: "joe@example.com"), invitation_token: invitation.token
      joe = User.find_by(email_address: "joe@example.com")
      expect(joe.follows?(alice)).to be_truthy
    end
    it "makes the inviter follow the user" do
      alice = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
      post :create, user: Fabricate.attributes_for(:user, email_address: "joe@example.com"), invitation_token: invitation.token
      joe = User.find_by(email_address: "joe@example.com")
      expect(alice.follows?(joe)).to be_truthy
    end
    it "expires the invitation upon acceptance" do
      alice = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
      post :create, user: Fabricate.attributes_for(:user, email_address: "joe@example.com"), invitation_token: invitation.token
      expect(Invitation.first.token).to be_nil
    end


    context "email sending" do
      after(:each) do
        ActionMailer::Base.deliveries.clear
      end
      it "creates an email" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(ActionMailer::Base.deliveries).to be_present
      end
      it "sends the email to the correct address" do
        user = Fabricate.attributes_for(:user)
        post :create, user: user
        message = ActionMailer::Base.deliveries.last
        expect(message.to.first).to eq(User.first.email_address)
      end
      it "contains the correct body" do
        user = Fabricate.attributes_for(:user)
        post :create, user: user
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix!")
      end
      it "doesn't send an email if inputs are invalid" do
        post :create, user: Fabricate.attributes_for(:user, email_address: "")
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe 'GET show' do
    after { ActionMailer::Base.deliveries.clear }
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end
    it "sets the @user variable from parameters" do
      set_current_user
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET new_with_invitation_token' do
    after { ActionMailer::Base.deliveries.clear }
    it "renders the :new template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    it "sets @user with recipients's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email_address).to eq(invitation.recipient_email)
    end
    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: 12345
      expect(response).to redirect_to expired_token_path
    end
  end
end