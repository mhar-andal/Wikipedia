class ArticlesController < ApplicationController
  def index
    @articles = Article.alphabetical
  end

  def show
    @article = Article.find(params[:id])
  end
end
