class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    unless @genre.save
      flash[:alert] = "ジャンルを入力してください"
    end
    redirect_to request.referer
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンルを入力してください"
      render 'edit'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
