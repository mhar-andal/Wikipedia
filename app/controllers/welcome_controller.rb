class WelcomeController < ApplicationController
  def index
    @featured_article = Article.find((1..Article.all.count).to_a.sample)
  end
end
