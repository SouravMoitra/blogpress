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
end
