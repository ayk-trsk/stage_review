class Public::StagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @stages = Stage.where(genre_id: params[:genre_id]).order(start_date: :desc).page(params[:page]).per(10)
    elsif params[:sort] == 'now'
      @stages = Stage.stages_now.order(start_date: :desc).page(params[:page]).per(10)
    elsif params[:sort] == 'coming'
      @stages = Stage.stages_coming.order(start_date: :asc).page(params[:page]).per(10)
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
      redirect_to stage_path(@stage)
    else
      render 'new'
    end
  end

  def show
    @stage = Stage.find(params[:id])
    @reviews = Review.where.not(body: "").where(stage_id: params[:id]).order(created_at: :desc)
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

  def search
    split_keyword = params[:keyword].split(/[[:blank:]]+/)
    @stages = []
    split_keyword.each do |keyword|
      next if keyword == ""

      @stages += Stage.where('name LIKE(?)', "%#{keyword}%")
    end
    @stages.uniq! # 重複した商品を削除する
    @stages = Kaminari.paginate_array(@stages).page(params[:page])
    render "index"
  end

  private

  def stage_params
    params.require(:stage).permit(:name, :genre_id, :start_date, :end_date, :detail)
  end
end
