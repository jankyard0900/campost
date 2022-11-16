class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @areas = Area.all
    @area = Area.new
    @categories = Category.all
    @category = Category.new
  end
end
