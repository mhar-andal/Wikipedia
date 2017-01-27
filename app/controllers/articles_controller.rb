class ArticlesController < ApplicationController
  include SessionsHelper
  def index
    @articles = Article.alphabetical
    # @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new
    @article.author_id = current_user.id
    @article.submission_status = "unsubmitted"
    @article.category_id = params[:category_id]
    @revision = Revision.new(article_params)

    if @revision.title? && @revision.paragraph? && @article.save
    	@article.revisions << @revision
    	if @revision.save
      		redirect_to @article, notice: 'Article was successfully created.'
      	else
      		render :new, status: 422
      	end
    else
    	flash[:notice] = 'You need a title!' if !@revision.title?
    	flash[:alert] = 'You need a paragraph!' if !@revision.paragraph?
      	render :new
    end
  end

  def edit
  	@article = Article.find(params[:id])
  	puts "3" * 150
  	redirect_to @article, notice: 'Article EDITED'
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  def update_category
    article = Article.find(params[:article_id])
    article.update(category_id: params[:category_id])
    redirect_to article_path(article)
  end

  private
  	def article_params
    	params.require(:revision).permit(:title, :paragraph)
  	end
end
