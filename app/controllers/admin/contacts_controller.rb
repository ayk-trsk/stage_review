class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @contacts = Contact.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
