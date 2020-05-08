module UsersHelper

    # Returns the Gravatar for the given user.
    def gravatar_for(user, options = { size: 80 })
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.email, class: "gravatar")
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

  end