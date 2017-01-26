class ArticlesController < ApplicationController
  def index
    @articles = Article.alphabetical
  end
end
