class StaticPagesController < ApplicationController
  include StaticPagesHelper
  def recent
    vars = request.query_parameters
    @posts = Post.where(:created_at => 1.month.ago..Time.now)
    if !vars.empty? # If true, user is going to selected posts.
      @posts = Post.first
    end
  end

  def selected
    @selected_topics = get_selected_topics.empty? ? "News" : get_selected_topics
    @posts = Post.where(topic: @selected_topics)
  end

  def select
    @topic = params[:topic]
    # Check if in array remove, otherwise add to array.
    toggle_topic(@topic)
    controller = request.headers["HTTP_REFERER"]
    if controller == "http://localhost:3000/selected"
      redirect_to '/selected'
    end
  end
end
