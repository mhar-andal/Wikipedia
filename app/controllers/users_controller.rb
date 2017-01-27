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

    p "HI FROM ADMIN_PANEL!!!!!!!!!!!!"
    p params
    respond_to do |format|
      format.html
      format.json
    end
  end

  def post_admin_panel
    p "hello"
    @current_search = "asd"
    @unpublished = Article.where("submission_status = 'need sources'")

    render :admin_panel
  end

private
  def user_deets
      params.require(:user).permit(:username, :password)
  end
end
