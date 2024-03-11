module SessionsHelper

  # login using given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # return user logging in now (if it exists)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # return true if user is logging in, else return false
  def logged_in?
    !current_user.nil?
  end

  # logout current user
  def log_out
    reset_session
    @current_user = nil   # for safe
  end

end
