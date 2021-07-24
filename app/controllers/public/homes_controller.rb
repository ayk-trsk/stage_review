class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @reviews = Review.limit(5).order(created_at: :desc)
    @stages_now = Stage.where("start_date <= ?", Date.today).where("end_date >= ?", Date.today).limit(5).order(start_date: :desc)
    @stages_coming = Stage.where("start_date > ?", Date.today).limit(5).order(start_date: :asc)
  end

  def about; end
end
