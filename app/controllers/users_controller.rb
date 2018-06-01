class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_login, only: [:edit, :update, :show]
  before_action :is_current_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.name}! Your account has been successfully created"
      redirect_to @user
    else
      flash.now[:error] = "Form has one or more errors!"
      render :new
    end
  end

  def show
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your profile has been successfully updated!"
      redirect_to @user
    else
      flash.now[:error] = "Form has one or more errors!"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def is_current_user
    redirect_to edit_user_path(current_user) unless current_user? @user
  end
end
