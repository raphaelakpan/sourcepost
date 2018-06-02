class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def require_login
    unless logged_in?
      store_location
      flash[:warning] = 'Please login to continue'
      redirect_to login_path
    end
  end

  def not_found
    flash[:warning] = 'Requested page not found!'
    redirect_to root_path
  end
end
