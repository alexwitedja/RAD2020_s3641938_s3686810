class SettingsController < ApplicationController
  include UsersHelper

  def profile
    @user = current_user
  end

  def posts
    @posts = get_posts_by_user(current_user.id)
  end

  def comments 
    @comments = get_comments_by_user(current_user.id)
  end

  def receivedcomments
    @receivedcomments = get_comments_to_user(current_user.id)
  end


end
