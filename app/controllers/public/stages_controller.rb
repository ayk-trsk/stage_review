class Public::StagesController < ApplicationController
  def index
    @stages = Stage.all
  end

  def new
    @stage = Stage.new
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to stages_path
    else
      render 'new'
    end
  end

  def show
    @stage = Stage.find(params[:id])
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    @stage = Stage.find(params[:id])
    if @stage.update(stage_params)
      redirect_to stage_path
    else
      render 'edit'
    end
  end

  private

  def stage_params
    params.require(:stage).permit(:name, :genre_id, :start_date, :end_date, :detail)
  end
end
