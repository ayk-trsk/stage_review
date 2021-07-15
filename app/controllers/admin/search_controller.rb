class Admin::SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    if @model == 'stage'
      @stages = Stage.where("name LIKE ?", "%#{@value}%")
    elsif @model == 'user'
      @users = User.where("name LIKE ?", "%#{@value}%")
    end
  end
end
