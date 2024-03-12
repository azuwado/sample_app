module SessionsHelper

  # login using given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # remember user in database for permanent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # return user according to token-cookie
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # return true if user is logging in, else return false
  def logged_in?
    !current_user.nil?
  end

  # destroy permanent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # logout current user
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil   # for safe
  end

end
