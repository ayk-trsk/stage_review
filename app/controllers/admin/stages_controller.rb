class Admin::StagesController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @stages = Stage.where(genre_id: params[:genre_id]).order(start_date: :desc).page(params[:page]).per(10)
    else
      @stages = Stage.all.order(start_date: :desc).page(params[:page]).per(10)
    end
  end

  def new
    @stage = Stage.new
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to admin_stage_path(@stage)
    else
      render "admin/stages/new"
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
      redirect_to admin_stage_path
    else
      render "admin/stages/edit"
    end
  end

  def destroy
    @stage = Stage.find(params[:id])
    @stage.destroy
    redirect_to admin_stages_path
  end

  private

  def stage_params
    params.require(:stage).permit(:name, :genre_id, :start_date, :end_date, :detail)
  end
end
