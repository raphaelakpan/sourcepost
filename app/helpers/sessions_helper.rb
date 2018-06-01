module SessionsHelper
  def log_in(user, remember: false)
    session[:user_id] = user.id
    remember user if remember
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    remove_user_session
    forget @current_user
    @current_user = nil
  end

  def remove_user_session
    session.delete(:user_id)
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def redirect_back_or_default(default)
    redirect_to session[:forwarding_url] || default
    remove_location
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def remove_location
    session.delete(:forwarding_url)
  end
end
