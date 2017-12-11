require 'spec_helper'

describe VideosController do
  let(:video1) { Fabricate(:video)}
  let(:video2) { Fabricate(:video)}
  let(:video3) { Fabricate(:video)}

  describe 'GET show' do
    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets up @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
    end
    context "with un-authenticated user" do
      it "redirects to login page" do
        get :show, id: video1.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET search' do
    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets up the @result variable" do
        futurama = Fabricate(:video, title: "Futurama")
        get :search, terms: "ama"
        expect(assigns(:result)).to eq([futurama])
      end

      it "renders the template" do
        get :search, terms: "random"
        expect(response).to render_template("search")
      end
    end
    context "with un-authenticated user" do
      it "redirects to the login page" do
        get :search, terms: "random"
        expect(response).to redirect_to login_path
      end
    end
  end
end