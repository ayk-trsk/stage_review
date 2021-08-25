class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @reviews = Review.where.not(body: "").limit(5).order(created_at: :desc)
    @stages_now = Stage.stages_now.limit(5).order(start_date: :desc)
    @stages_coming = Stage.stages_coming.limit(5).order(start_date: :asc)
  end

  def about; end
end
