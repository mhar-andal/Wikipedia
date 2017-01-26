class ArticlesController < ApplicationController
  def index
    # @articles = Article.alphabetical
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
