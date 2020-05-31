class StaticPagesController < ApplicationController
  include StaticPagesHelper
  def recent
    @posts = Post.where(:created_at => 1.month.ago..Time.now)
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
    if !controller.nil?
      redirect_to request.referrer
    else
      redirect_to '/selected'
    end
  end

  def search
    if params[:search].blank?
      redirect_to(home_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      user = User.find_by(name: @parameter)
      if !user.nil?
        @posts = user.posts
      else
        @posts = Post.where("lower(title) LIKE :search OR lower(content) LIKE :search OR lower(topic) LIKE :search", search: '%'+@parameter+'%')
      end
    end
  end
end
