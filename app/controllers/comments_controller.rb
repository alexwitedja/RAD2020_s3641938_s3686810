class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def create 
    new_content = params[:post][:content]
    post_id = params[:post_id]
    user_id = current_user.id

    new_comment = Comment.create({content: new_content, post_id: post_id, user_id: user_id})
    if new_comment.save
      redirect_to post_url(post_id)
    else
      flash[:alert] = "Comment content can't be empty."
    end
  end

  private

    def logged_in_user
      if !logged_in?
        flash[:danger] = "You need to log in to post a comment"
        redirect_to "/home"
      end
    end
end