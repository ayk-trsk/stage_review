class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  def create
    @stage = Stage.find(params[:stage_id])
    bookmark = current_user.bookmarks.new(stage_id: @stage.id)
    bookmark.save
  end

  def destroy
    @stage = Stage.find(params[:stage_id])
    bookmark = current_user.bookmarks.find_by(stage_id: @stage.id)
    bookmark.destroy
  end
end
