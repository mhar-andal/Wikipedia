class ArticlesController < ApplicationController
  include SessionsHelper
  def index
    # @articles = Article.alphabetical
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
    @article.revisions.find_by(publication_status: "true")
  end

  def new
    @article = Article.new

  end

  def create
    @article = Article.new
    @article.author_id = current_user.id
    @article.submission_status = "unsubmitted"
    @revision = Revision.new(article_params)

    if @article.save
    	@article.revisions << @revision
    	if @revision.save
      		redirect_to @article, notice: 'Article was successfully created.'
      	else
      		render :new, status: 422
      	end
    else
      render :new, status: 422
    end
  end

  def edit
  	
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  private
  	def article_params
    	params.require(:revision).permit(:title, :paragraph)
  	end
   
end
