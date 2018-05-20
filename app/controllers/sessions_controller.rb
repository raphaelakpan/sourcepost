class SessionsController < ApplicationController
  before_action :find_user, only: [:create]

  def new
    @user = User.new
  end

  def create
    if @user&.authenticate(session_params[:password])
      log_in @user, remember: session_params[:remember_me] == '1'
      flash[:success] = "Logged in successfully as #{@user.name}"
      redirect_to @user
    else
      @user = User.new(session_params)
      flash.now[:error] = 'Invalid Email/Password Combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find_by(
      email: session_params[:email].downcase
    )
  end

  def session_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
