class SectionsController < ApplicationController
  include SessionsHelper
  
  def new
  	@article = Article.find(params[:article_id])
  	@section = Section.new
  end

  def create
    @article = Article.find(params[:article_id])
    @section = Section.new
    @revision = Revision.new(section_params)

    if @revision.title? && @revision.paragraph? && article_owner
    	 @article.sections << @section
       @section.revisions << @revision
       redirect_to @article, notice: 'Section was added.'
    else
       flash.clear
       flash[:notice] = 'You need a title!' if !@revision.title?
       flash[:alert] = 'You need a paragraph!' if !@revision.paragraph?
       render :new
    end
  end

  def edit
  	@article = Article.find(params[:article_id])
  	@section = Section.find(params[:id])
    @revision = @section.revisions.last
    if !article_owner
    	redirect_to @article, notice:"You do not have permission to edit this article."
    end
  end

  def update
    @article = Article.find(params[:article_id])
    section = Section.find(params[:id])
    @revision = Revision.new(section_params)

    if @revision.title? && @revision.paragraph? && article_owner
       section.revisions << @revision
       redirect_to @article, notice:"Section was updated!"
    else
       flash.discard[:notice] = 'You need a title!' if !@revision.title?
       flash.discard[:alert] = 'You need a paragraph!' if !@revision.paragraph?
       render :new, notice:"You didn't add a section"
    end
  end

  def destroy
  	@article = Article.find(params[:article_id])
  	section = Section.find(params[:id])
  	section.destroy
  	redirect_to @article, notice: 'Section was deleted.'
  end

  private
    def section_params
  		params.require(:revision).permit(:title, :paragraph)
  	end

end