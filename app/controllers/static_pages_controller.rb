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
    if controller == "http://localhost:3000/selected"
      redirect_to '/selected'
    end
  end

  def home_search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Post.where("lower(title) LIKE :search", search: '%'+@parameter+'%')
    end
  end

  def selected_search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase

      @selected_topics = get_selected_topics.empty? ? "News" : get_selected_topics
      @posts = Post.where(topic: @selected_topics)
      @selected_posts = @posts.where("lower(title) LIKE :search", search: '%'+@parameter+'%')

    end



  end


end
