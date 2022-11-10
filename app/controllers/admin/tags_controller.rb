class Admin::TagsController < ApplicationController
  def index
    @areas = Area.all
    @area = Area.new
    @categories = Category.all
    @category = Category.new
  end
end
