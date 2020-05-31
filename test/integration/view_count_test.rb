require 'test_helper'

class ViewCountTest < ActionDispatch::IntegrationTest
  def setup
    @post = Post.first
  end

  test "View count should increase by 1 after we view the post." do
    assert_equal @post.view_count, 0
    get post_path(@post)
    assert_equal Post.first.view_count, 1
  end
end
