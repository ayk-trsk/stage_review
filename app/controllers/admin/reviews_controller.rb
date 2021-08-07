class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:stage_id]
      @stage = Stage.find(params[:stage_id])
      @reviews = Review.where(stage_id: params[:stage_id]).order(created_at: :desc).page(params[:page]).per(10)
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @reviews = Review.where(user_id: params[:user_id]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(10)
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
      redirect_to admin_review_path
    else
      render 'admin/reviews'
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :rate, :body, :date, :place, :user_id, :stage_id)
  end
end
