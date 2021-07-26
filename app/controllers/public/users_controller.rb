class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: @user.id).order(created_at: :desc)
    if params[:sort]
      selection = params[:sort]
      reviews = Review.sort(selection)
    else
      reviews = Review.order(created_at: :desc)
    end
    my_reviews = reviews.select { |review| review.user_id == @user.id }
    @reviews = Kaminari.paginate_array(my_reviews).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def quit; end

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
