class UsersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    if logged_in?
      redirect_to home_path
    end
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :mobile)
    end

    def logged_in_user
      if logged_in?
        redirect_to "/home"
      end
    end
end