module UserHelper
  def title_string
    if @user.admin == true
      "Admin"
    else
      "Member"
    end
  end
end
