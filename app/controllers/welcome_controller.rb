class WelcomeController < ApplicationController
  def index
    @featured_article = Article.find((1..Article.all.count).to_a.sample).newest_revision
    @newest_article = Article.all.order(created_at: :desc).first.newest_revision
  end
end
