class VideosController < ApplicationController

  def index
    @video = Video.all
    @category = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end
end