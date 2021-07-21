class Admin::SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    case @model
    when 'stage'
      @stages = Stage.where("name LIKE ?", "%#{@value}%")
    when 'user'
      @users = User.where("name LIKE ?", "%#{@value}%")
    end
  end
end
