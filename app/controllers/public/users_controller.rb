class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: params[:id]).order(created_at: :desc).all
    @bookmarks = Bookmark.where(user_id: @user.id).order(created_at: :desc).all
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def quit
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
