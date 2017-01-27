class BibliographiesController < ApplicationController
  include SessionsHelper

  def new
  	@article = Article.find(params[:article_id])
  	@bib = Bibliography.new
  end

  def create
    @article = Article.find(params[:article_id])
    bib = Bibliography.new(bib_params)

    if bib.reference? && bib.resource_type? && article_owner
    	@article.bibliographies << bib
      	redirect_to @article, notice: 'Bibliography was added.'
      else
      	redirect_to @article, notice:"Bibliography wasn't added."
    end
  end

  def edit
  	@article = Article.find(params[:article_id])
  	@bib = Bibliography.find(params[:id])
    if !article_owner
       	flash[:no_access] = "You do not have permission to edit this article."
    	redirect_to @article
    end
  end

  def update
    bib = Bibliography.find(params[:id])
    bib.assign_attributes(bib_params)
    @article = Article.find(params[:article_id])
    if bib.reference? && bib.resource_type? && article_owner && bib.save
      redirect_to @article
    else
      flash[:alert] = "Bibliography can't be blank!"
      redirect_to edit_article_bibliography_path
    end
  end

  def destroy
  	@article = Article.find(params[:article_id])
  	bib = Bibliography.find(params[:id])
  	bib.destroy
  	redirect_to @article, notice: 'Bibliography was deleted.'
  end

  private
    def bib_params
  		params.require(:bibliography).permit(:reference, :resource_type)
  	end

end
