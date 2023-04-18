class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @products = Product.order(id: :desc).all
    @categories = Category.order(id: :desc).all
  end
end
