class UsersController < ApplicationController
  include UsersHelper
  before_action :logged_in_user, only: [:new, :create]

  def new
    if logged_in?
      redirect_to home_path
    end
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = get_posts_by_user(@user.id)
    @comments = get_comments_by_user(@user.id)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(edit_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else 
      render 'edit'
    end
  end

  def edit_pass
    @user = User.find(params[:id])
  end

  def update_pass
    @user = User.find(params[:id])
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.valid?(:update_password)
    if @user.errors.any?
      render 'edit_pass'
    else
      @user.update_attributes(edit_pass_params)
      flash[:success] = "Password changed"
      redirect_to @user
    end
  end

  def edit_avatar
    @user = User.find(params[:id])
  end

  def update_avatar
    @user = User.find(params[:id])
    @user.avatar.attach(params[:user][:avatar])
    flash[:success] = "Avatar changed"
    redirect_to @user
  end

  def edit_card
    @user = User.find(params[:id])
  end

  def update_card
    @user = User.find(params[:id])
    @user.card.attach(params[:user][:card])
    if @user.update_attributes(edit_verification_params)
      flash[:success] = "Verification information updated"
      redirect_to @user
    else
      render 'edit_card'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :mobile)
    end
    
    def edit_params
      params.require(:user).permit(:name, :email, :mobile, :city, :info)
    end

    def edit_pass_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def edit_verification_params
      params.require(:user).permit(:student_number, :full_name)
    end

    def logged_in_user
      if logged_in?
        redirect_to "/home"
      end
    end
end