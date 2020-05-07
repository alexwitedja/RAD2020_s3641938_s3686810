class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    if @user.posts.create(post_params)
      redirect_to home_path
    else
      redierct_to 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  private
    def post_params
      params.require(:post).permit(:topic, :title, :content)
    end

    def logged_in_user
      if !logged_in?
        flash[:danger] = "You are not logged in"
        redirect_to "/home"
      end
    end
end
