module UsersHelper

  # Returns the avatar for the given user, Gravatar if none attached.
  def user_avatar(user, options = { size: 80 })
    size = options[:size]
    if user.avatar.attached?
      image_tag(user.avatar, height: size, width: size)
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.email, class: "gravatar")
    end
  end

  # Returns recently active members.
  def get_recent_members
    # To be implemented
    @users = User.all
  end
    
  def get_posts_by_user(user_id)
    Post.where(:user_id => user_id)
  end

  def get_comments_by_user(user_id)
    Comment.where(:user_id => user_id)
  end

  def get_comments_to_user(user_id)
    Comment.where(:post_id => get_posts_by_user(user_id))
  end

end