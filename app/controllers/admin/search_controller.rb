class Admin::SearchController < ApplicationController
  before_action :authenticate_admin!
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
