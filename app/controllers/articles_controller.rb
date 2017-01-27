class ArticlesController < ApplicationController
  include SessionsHelper
  skip_before_filter  :verify_authenticity_token
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
    @revision = Revision.new(article_params)
    @article.category_id = params[:category_id]

    if @revision.title? && @revision.paragraph? && @article.save
    	@article.revisions << @revision
      redirect_to @article, notice: 'Article was successfully created.'
    else
      flash.clear
    	flash[:notice] = 'You need a title!' if !@revision.title?
    	flash[:alert] = 'You need a paragraph!' if !@revision.paragraph?
      render :new
    end
  end

  def edit
  	@article = Article.find(params[:id])
  	@revision = @article.revisions.last
    if !owner
       	flash[:no_access] = "You do not have permission to edit this article."
    	redirect_to @article
    end
  end

  def update
  	@article = Article.find(params[:id])
  	@revision = Revision.new(article_params)
  	if @revision.title? && @revision.paragraph?
  		@article.revisions << @revision
      redirect_to @article, notice: 'Article was updated.'
    else
      flash.clear
    	flash[:notice] = 'You need a title!' if !@revision.title?
    	flash[:alert] = 'You need a paragraph!' if !@revision.paragraph?
      redirect_to edit_article_path
    end
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

  def update_publish
    @article = Article.find(params[:id])
    if @article.newest_revision(false).publication_status == false
      @article.newest_revision.update_attributes(:publication_status => false)
      @article.newest_revision(false).update_attributes(:publication_status => true)
      @article.update_attributes(:submission_status => "unsubmitted")
      @article.save
    end

    redirect_to "/users/#{current_user.id}/admin_panel"
  end

  def deny
    @article = Article.find(params[:id])
    @article.update_attributes(:submission_status => "needs sources")
    @article.save

    redirect_to "/users/#{current_user.id}/admin_panel"
  end

  private
  	def article_params
    	params.require(:revision).permit(:title, :paragraph)
  	end
end
