class StaticPagesController < ApplicationController
  include StaticPagesHelper
  @@selected_topics = []

  def recent
    vars = request.query_parameters
    @posts = Post.where(:created_at => 1.month.ago..Time.now)
    if !vars.empty? # If true, user is going to selected posts.
      @posts = Post.first
    end
  end

  def selected
    @posts = Post.first
  end

  def select
    @topic = params[:topic]
    # Check if in array remove, otherwise add to array.
    toggle_topic(@topic)
  end
end
