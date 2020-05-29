require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:alex)
    @post = posts(:game_post)
    @comments = Comment.new(content: "Wow!", post_id: @post.id, user_id: @user.id)
  end

  test "Should be valid" do
    assert @comments.valid?
  end

  test "Should be invalid" do
    @comments.content = ""
    assert_not @comments.valid?
  end
end
