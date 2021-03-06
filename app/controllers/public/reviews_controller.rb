class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    if params[:stage_id]
      @stage = Stage.find(params[:stage_id])
      @reviews = Review.where.not(body: "").where(stage_id: params[:stage_id]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @reviews = Review.where.not(body: "").order(created_at: :desc).page(params[:page]).per(10)
    end
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
    @review = Review.find(params[:id])
    @comments = @review.comments
    @comment = Comment.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path
    else
      render 'edit'
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rate, :body, :date, :place, :user_id, :stage_id)
  end

  def ensure_correct_user
    @review = Review.find(params[:id])
    @user = User.find(@review.user.id)
    unless @user == current_user
      redirect_to root_path
    end
  end
end
