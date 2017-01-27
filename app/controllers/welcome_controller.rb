class WelcomeController < ApplicationController
  def index
    @featured_article = Article.find((1..Article.all.count).to_a.sample).newest_revision
    @feat_article = Article.find((1..Article.all.count).to_a.sample)
    @newest_article = Article.newest_published.newest_revision
    @new_article = Article.newest_published
  end
end
