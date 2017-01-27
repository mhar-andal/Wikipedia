class UsersController < ApplicationController
  include SessionsHelper
  skip_before_filter  :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_deets)
    if @user.save
      login_user
      redirect_to(root_path)
    else
      render action: 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
  end

  def update
  end

  def admin_panel
    @current_search = "Unpublished"
    @unpublished = Article.where("submission_status = 'submitted'")
  end

  def article_manager
    p "****************"
    p "FILTER"
    p params[:filter_by]
    if current_user.id == params[:id].to_i
      @user = current_user
      case params[:filter_by]
      when nil
        @title = "Your articles"
        @articles = @user.articles
      when "published"
        @title = "Your published articles"
        @articles = @user.published_articles
      when "unpublished"
        @title = "Your unpublished articles"
        @articles = @user.unpublished_articles
      end

    else
      redirect_to(root_path)
    end
  end

private
  def user_deets
      params.require(:user).permit(:username, :password)
  end
end
