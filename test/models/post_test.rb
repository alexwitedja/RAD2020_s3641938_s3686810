require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "user@example.com", mobile: "1234567890",
                      password: "foobar", password_confirmation: "foobar")
    @post = @user.posts.new(topic: "A.I", title: "A.I is very cool!",
                              content: "blah blah A.I blah blah")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "Content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end

  test "Topic should be present" do
    @post.topic = " "
    assert_not @post.valid?
  end

  test "Title should be present" do
    @post.title = " "
    assert_not @post.valid?
  end
end
