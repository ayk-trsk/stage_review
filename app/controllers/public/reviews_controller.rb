class Public::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @stage = Stage.find(params[:stage_id])
    @review = Review.new
  end

  def create
    @stage = Stage.find(params[:stage_id])
    @review = Review.new(review_params)
    @review.stage_id = @stage.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to stage_path(@stage)
    else
      render 'new'
    end
  end

  def show
    @stage = Stage.find(params[:stage_id])
    @review = Review.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:title, :rate, :body, :date, :place, :user_id, :book_id)
  end
end

