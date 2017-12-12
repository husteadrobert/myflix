class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.video_id = @video.id
    if @review.save 
      flash[:notice] = "Thank you for your review!"
      redirect_to @video
    else
      flash[:danger] = "An error occured!"
      render "videos/video"
    end
  end


  private
    def review_params
      params.require(:review).permit!
    end
end