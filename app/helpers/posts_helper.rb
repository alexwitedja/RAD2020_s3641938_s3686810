module PostsHelper
  def get_topics
    @topics = ["A.I", "Game", "V.R", "REST"]
  end
  
  # Get recent posts in this month
  def get_recent_posts
    Post.where(:created_at => 1.month.ago..Time.now)
  end

  # Get 5 most viewed posts, to be implemented
  def get_popular_posts
    Post.all
  end
end
