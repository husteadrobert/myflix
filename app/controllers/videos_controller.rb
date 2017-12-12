class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
    render 'video'
  end

  def genre
    @category = Category.find(params[:id])
    render 'genre'
  end

  def search
    terms = params[:terms]
    @result = Video.search_by_title(terms)
  end

end