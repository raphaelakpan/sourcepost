class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def not_found
    flash[:warning] = 'Requested page not found!'
    redirect_to root_path
  end
end
