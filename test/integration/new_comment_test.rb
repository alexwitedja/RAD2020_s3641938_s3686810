require 'test_helper'

class NewCommentTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alex)
    @post = posts(:vr_post)
    
    log_in_as(@user, remember_me: '0')
  end

  test "Post comments only visible to logged in users" do
    delete logout_path
    get post_path(@post)

    assert_select ".new-comment-form", count: 0
  end

  test "Post comment, comment count increases by 1" do
    get post_path(@post)
    # Only one comment in the beginning for this post.
    assert_select ".comments", count: 1
    # Add a comment.
    post post_comments_path(@post.id), params: { post: { content: "Hello this is a test comment "} }
    follow_redirect!
    # There should be 2 comments now.
    assert_select ".comments", count: 2
    assert_equal @post.comments.count, 2
    # Posting empty comment will alert user.
    post post_comments_path(@post.id), params: { post: { content: " "} }
    assert_not flash[:alert].empty?
    # Comments count should not increase.
    assert_equal @post.comments.count, 2
  end
end