class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    @comment = Comment.new(comment_params)
    @comment.review_id = @review.id
    @comment.user_id = current_user.id
    render 'error' unless @comment.save
  end

  def destroy
    @review = Review.find(params[:review_id])
    comment = @review.comments.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
