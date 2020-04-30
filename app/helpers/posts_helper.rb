module PostsHelper
  # Get all posts in one month
  def get_posts_one_month
    @posts = Post.where(:created_at => 1.month.ago..Time.now)
  end
end
