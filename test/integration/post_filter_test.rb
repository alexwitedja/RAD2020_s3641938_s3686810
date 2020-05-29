require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # Contains tests that have to do with filtering posts in the home screen.
  def setup
    @user = users(:alex)
    @post1 = posts(:vr_post)
    @post2 = posts(:game_post)
    @post3 = posts(:ai_post)
    @post4 = posts(:game_post2)
    log_in_as(@user, remember_me: '0')
  end

  test "See recent post doesn't show posts that are over 1 month old" do
    get home_path
    posts = css_select(".post")
    # @post3 is created_at two months ago therefore only 2 are rendered
    assert_select "div.post", /#{@post1.title}/
    assert_select "div.post", /#{@post2.title}/
    assert_select "div.post", /^((?!#{@post3.topic}).)*$/
  end

  test "Select tag shows the correct posts" do
    get selected_path
    posts = css_select(".post")
    # Empty because no topics were selected
    assert_equal posts.count, 0
    # Select A.I tag
    post select_path, params: { topic: "A.I" } 
    follow_redirect!
    # Contains A.I topic
    assert_select "div.post", /#{@post3.topic}/
    # Doesn't contain other topics
    assert_select "div.post", /^((?!#{@post1.topic}).)*$/
    assert_select "div.post", /^((?!#{@post2.topic}).)*$/
    # Select Game tag
    post select_path, params: { topic: "Game" }
    follow_redirect!
    # Contains both A.I and Game topics
    assert_select "div.post", /#{@post3.topic}/
    assert_select "div.post", /#{@post2.topic}/
    # Deselects A.I topic
    post select_path, params: { topic: "A.I" }
    follow_redirect!
    # Should not contain A.I topic
    assert_select "div.post", /^((?!#{@post3.topic}).)*$/
    # Should still contain Game topic
    assert_select "div.post", /#{@post2.topic}/
  end

  test "Search functionality shows correct posts" do
  end
end