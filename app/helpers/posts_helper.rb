module PostsHelper
  def get_topics
    @topics = ["A.I", "Game", "V.R", "Rest"]
  end

  def get_popular_topics
    topic_list = ["A.I", "Game", "V.R", "Rest"]
    view_counts = []
    topic_list.each do |topic|
      views = 0
      Post.where(:topic => topic).each do |post|
        views += post.view_count
      end
      view_counts.push(views)
    end

    @popular_topics = ["News"]

    largest_index = view_counts.index(view_counts.max)
    @popular_topics.push(topic_list[largest_index])
    topic_list.delete_at(largest_index)
    view_counts.delete_at(largest_index)
    second_largest_index = view_counts.index(view_counts.max)
    @popular_topics.push(topic_list[second_largest_index])

    @popular_topics
  end
  
  # Get recent posts in this month
  def get_recent_posts
    Post.where(:created_at => 1.month.ago..Time.now)
  end

  # Get 5 most viewed posts, to be implemented
  def get_popular_posts
    Post.first(5)
  end

  def current_post(post_id)
    @current_post = Post.find_by(id: post_id)
  end
end
