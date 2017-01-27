class WelcomeController < ApplicationController
  def index
    @featured_article = Article.find((1..Article.all.count).to_a.sample).newest_revision
    @newest_article = Article.newest_published.newest_revision
  end
end
