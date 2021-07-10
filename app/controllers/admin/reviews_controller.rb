class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    if params[:stage_id]
      @stage = Stage.find(params[:stage_id])
      @reviews = Review.where(stage_id: params[:stage_id]).order(created_at: :desc).all
    else
      @reviews = Review.order(created_at: :desc).all
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
    @stages = Stage.all
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path
    else
      render 'admin/reviews '
    end
  end
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:title, :rate, :body, :date, :place, :user_id, :stage_id)
  end
end
