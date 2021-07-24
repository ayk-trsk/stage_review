class Public::ReviewsController < ApplicationController
  def index
    if params[:stage_id]
      @stage = Stage.find(params[:stage_id])
      @reviews = Review.where(stage_id: params[:stage_id]).order(created_at: :desc).page(params[:page])
    else
      @reviews = Review.all.order(created_at: :desc).page(params[:page])
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
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_path(current_user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rate, :body, :date, :place, :user_id, :stage_id)
  end
end
