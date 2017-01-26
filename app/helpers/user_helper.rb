module UserHelper
  def title_string
    if @user.admin == true
      "Admin"
    else
      "Member"
    end
  end

  def is_admin
    current_user.admin
  end
end
