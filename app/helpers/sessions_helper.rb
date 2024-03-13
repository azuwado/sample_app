module SessionsHelper

  # login using given user
  def log_in(user)
    session[:user_id] = user.id
    # prevent session replay attack
    session[:session_token] = user.session_token
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
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # return true if given user is same as current_user
  def current_user?(user)
    user && user == current_user
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

  #store url trying to access
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
