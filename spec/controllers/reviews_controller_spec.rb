require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "when user is autherized" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      context "with valid inputs" do
        it "creates a review associtead with the video" do
          video = Fabricate(:video)
          user = current_user
          review = Fabricate.attributes_for(:review, video: video, user: user)
          post :create, video_id: video.id, review: review
          expect(Review.first.video).to eq(video)
        end
        it "creates a review associated with the signed in user" do
          video = Fabricate(:video)
          user = current_user
          review = Fabricate.attributes_for(:review, video: video, user: user)
          post :create, video_id: video.id, review: review
          expect(Review.first.user).to eq(user)
        end
        it "redirects to the video page" do
          video = Fabricate(:video)
          user = current_user
          review = Fabricate.attributes_for(:review, video: video, user: user)
          post :create, video_id: video.id, review: review
          expect(response).to redirect_to video
        end
        it "creates a review" do
          video = Fabricate(:video)
          user = current_user
          review = Fabricate.attributes_for(:review, video: video, user: user)
          post :create, video_id: video.id, review: review
          expect(Review.count).to eq(1)
        end
      end
      context "with invalid inputs" do
        it "doesn't create a review" do
          video = Fabricate(:video)
          post :create, review: {rating: 5}, video_id: video.id
          expect(Review.count).to eq(0)
          video2 = Fabricate(:video)
          post :create, review: {body: "Hello!"}, video_id: video2.id
          expect(Review.count).to eq(0)
        end
        it "renders the videos/video template" do
          video = Fabricate(:video)
          post :create, review: {rating: 5}, video_id: video.id
          expect(response).to render_template("videos/video")
        end
        it "sets @video" do
          video = Fabricate(:video)
          post :create, review: {rating: 5}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end
      end
    end

    context "when user is NOT autherized" do
      it "should redirect to the login page" do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to login_path
      end
    end
  end
end