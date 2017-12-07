class VideosController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    render 'video'
  end

  def genre
    @category = Category.find(params[:id])
    render 'genre'
  end

end