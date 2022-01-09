class Admin::CategoriesController < ApplicationController

  username = ENV["username"]
  password = ENV["password"]

  http_basic_authenticate_with name: username, password: password
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  ## Removed destroy as not certain how it functions when there are products in the category being destroyed
  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
