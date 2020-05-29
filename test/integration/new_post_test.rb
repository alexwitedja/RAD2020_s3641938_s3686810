require 'test_helper'

class NewPostTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alex)
  end

  test "Non logged in users can't get to the new post form" do
    get new_post_path
    follow_redirect!
    # Will redirect to home_path
    assert_template 'static_pages/recent'
  end

  test "Logged in users create new posts" do
    get home_path
    # Three posts are initially shwon in recent.
    assert_select "div.post", { :count => 3 }
    log_in_as(@user, remember_me: '0')
    get new_post_path
    assert_template 'posts/new'
    # Creates a post with valid paramaters
    post posts_path, params: { post: { title: "Test post 4",
                                      content: "Halo",
                                      topic: "Game" } }
    follow_redirect!
    assert_template 'static_pages/recent'
    # After a successful create post there is now an additional post.
    assert_select "div.post", { :count =>  4 }
    # Creates post with empty topic
    post posts_path, params: { post: { title: "Test post 5",
                                      content: "Halo",
                                      topic: "" } }
    follow_redirect!
    # Now there should be a post with News as topic.
    assert_select "div.post", { :text => /News/, :count => 1}
    assert_select "div.post", { :count => 5 }
    # Posting with invalid content. empty title and empty content
    post posts_path, params: { post: { title: "",
                                      content: "",
                                      topic: "" } }
    # Should render the posts template and show an error_explanation.
    assert_template 'posts/new'
    assert_select "div#error_explanation"
  end
end