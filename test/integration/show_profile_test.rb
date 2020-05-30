require 'test_helper'

class ShowProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:alex)
    @user2 = users(:david)
  end

  test "There's a link to author profile in posts" do
    get home_path
    # Post has links to the author's name
    # 1 link from the icon, the other from the author's name (see _post.html.erb)
    assert_select ".post" do 
      assert_select "a[href=?]", "/users/1", count: 4
      assert_select "a[href=?]", "/users/2", count: 2
    end
  end

  test "There's a link to in icon to user profile" do
    get home_path
    # Post has likns to icon's profile
    assert_select ".recent-users" do
      assert_select "a[href=?]", "/users/1", count: 1
      assert_select "a[href=?]", "/users/2", count: 1
    end
  end

  test "Go to the link should see the correct user info" do
    get user_path(@user1)
    assert_template 'users/show'
    assert_select ".user-info", /#{@user1.name}/
    get user_path(@user2)
    assert_template 'users/show'
    assert_select ".user-info", /#{@user2.name}/
  end
end