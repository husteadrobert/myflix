require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    it "sets the @video to a new video" do
      # alice = Fabricate(:user, admin: true)
      # set_current_user(alice)
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end
    it "redirects the regular user to home path" do
      set_current_user
      get :new
      expect(page).to redirect_to home_path
    end
    it "sets the flash error message for regular users" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end
end