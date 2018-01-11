class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin
  def new
    @video = Video.new
  end

  def create
    @video = Video.create(video_params)
    if @video.save
      flash[:success] = "New Video Added: #{@video.title}"
      redirect_to new_admin_video_path
    else
      flash[:error] = "There was a problem."
      render :new
    end
  end

  private

    def require_admin
      if !current_user.admin?
        flash[:error] = "You must be an admin to do that."
        redirect_to home_path
      end
    end

    def video_params
      params.require(:video).permit!
    end
end