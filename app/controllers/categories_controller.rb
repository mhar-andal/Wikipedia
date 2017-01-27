class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:category][:name])
    if @category.save
      redirect_to articles_path, notice: 'Category was successfully created'
    else
      render :new, status: 422
    end

  end
end
