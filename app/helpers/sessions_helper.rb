module SessionsHelper
  def logged_in
    session[:user_id] != nil
  end

  def logout_user
    session[:user_id] = nil
  end

  def login_user
    session[:user_id] = @user.id
  end

  def current_user
   @current_user ||= User.find_by(id: session[:user_id])
  end

  def owner
    Article.find(params[:id]).author_id == session[:user_id]
  end

  def article_owner
    Article.find(params[:article_id]).author_id == session[:user_id]
  end
end

