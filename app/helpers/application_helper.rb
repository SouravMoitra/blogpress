module ApplicationHelper
  def user_signed_in
    unless user_signed_in?
      flash[:error] = "Sign in first"
      redirect_to new_user_session_url
    end
  end
end
