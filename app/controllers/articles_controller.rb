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
    revision = Revision.new(article_params)
    @article.category_id = params[:category_id]

    if revision.title? && revision.paragraph? && @article.save
    	@article.revisions << revision
    	if revision.save
    		note = Note.new(note_params)
    		if note.comment?
    			@article.notes << note
    		end
    		bib = Bibliography.new(bib_params)
    		if bib.reference? && bib.resource_type?
    			@article.bibliographies << bib
    		end
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
    	if @revision.save
      		redirect_to @article, notice: 'Article was updated.'
      	else
      		render :edit, status: 422 
      	end
    else
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

  private
  	def article_params
    	params.require(:revision).permit(:title, :paragraph)
  	end
<<<<<<< HEAD

  	def bib_params
  		params.require(:revision).permit(:reference, :resource_type)
  	end

  	def note_params
  		params.require(:revision).permit(:comment)
  	end
=======
>>>>>>> c30601b687d18f0d32d511d55282d66b5135f1c7
end
