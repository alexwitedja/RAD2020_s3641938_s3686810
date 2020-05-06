class StaticPagesController < ApplicationController
  def home
    vars = request.query_parameters
    @posts = Post.where(:created_at => 1.month.ago..Time.now)
    if !vars.empty? # If true, user is going to selected posts.
      @posts = Post.first
    end
  end
end
