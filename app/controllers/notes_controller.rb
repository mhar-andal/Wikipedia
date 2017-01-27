class NotesController < ApplicationController
  include SessionsHelper
  
  def new
  	@article = Article.find(params[:article_id])
  	@note = Note.new
  end

  def create
    @article = Article.find(params[:article_id])
    note = Note.new(note_params)

    if note.comment? && article_owner
    	@article.notes << note
      	redirect_to @article, notice: 'Note was added.'
      else
      	redirect_to @article, notice:"You didn't add a note"
    end
  end

  def edit
  	@article = Article.find(params[:article_id])
  	@note = Note.find(params[:id])
    if !article_owner
    	redirect_to @article, notice:"You do not have permission to edit this article."
    end
  end

  def update
    note = Note.find(params[:id])
    note.assign_attributes(note_params)
    @article = Article.find(params[:article_id])
    if note.comment? && article_owner && note.save
      redirect_to @article, notice:"Note was updated!"
    else
      redirect_to edit_article_note_path, notice:"Note can't be blank!"
    end
  end

  def destroy
  	@article = Article.find(params[:article_id])
  	note = Note.find(params[:id])
  	note.destroy
  	redirect_to @article, notice: 'Note was deleted.'
  end

  private
    def note_params
  		params.require(:note).permit(:comment)
  	end

end