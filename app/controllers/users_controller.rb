class UsersController < ApplicationController
  before_action :set_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome #{@user.name}! Your account has been successfully created"
      redirect_to @user
    else
      flash.now[:error] = "Form has one or more errors!"
      render :new
    end
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
