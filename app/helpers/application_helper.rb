module ApplicationHelper
  def user_signed_in
    unless user_signed_in?
      flash[:danger] = "Sign in first"
      redirect_to new_user_session_url
    end
  end

  def full_title(page_title = '')
    base_title = "BlogPress"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def is_admin?
    true if current_user.level == admin_level
  end
  # to return Level of user to determine he is author or not
  def is_author?
    true if current_user.level == author_level
  end
  # to return Level of user to determine he is registered or not
  def current_user_level
    current_user.level
  end
  # if the level is set to 2 the user is admin
  # returns 2
  def admin_level
    2
  end
  # if the level is set to 3 the user is author
  # returns 3
  def author_level
    3
  end
  # to determine the user is signed in and is admin if not sends back to root
  def admin_signin_status
    unless user_signed_in? && is_admin?
      redirect_to root_url
    end
  end
  # to determine the user is signed in and is author if not sends back to root
  def author_signin_status
    unless user_signed_in? && is_author?
      flash[:danger] = "You are not a author"
      redirect_to root_url
    end
  end
end
