module UserHelper
  def title_string
    if @user.admin == true
      "Admin"
    else
      "Member"
    end
  end

  def is_admin
    if logged_in
      current_user.admin
    else
      false
    end
  end
end
