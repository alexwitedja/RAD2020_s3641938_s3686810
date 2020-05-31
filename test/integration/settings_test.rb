require 'test_helper'

class SettingsTest < ActionDispatch::IntegrationTest

  def setup
    @user1 = users(:alex)
    @user2 = users(:david)
    log_in_as(@user1, remember_me: '0')
  end
  
  test "Setting button invisible to non logged in users." do
    delete logout_path
    get home_path
    # Setings button should not exist in the btn-group class
    assert_select ".btn-group" do
      assert_select "a[href=?]", settings_profile_path, count: 0
      assert_select "a[href=?]", home_path, count: 1
      assert_select "a[href=?]", selected_path, count: 1
    end
  end

  test "Open settings page after logging in." do
    get settings_profile_path
    assert_select "h4" do
      # There are 5 pages in settings
      assert_select "a", count: 5
    end
    # Should show profile template
    assert_template 'settings/profile'
    assert_select ".user-info", /#{@user1.name}/
  end

  test "Settings show posts" do
    get settings_posts_path
    assert_template 'settings/posts'
    # Should only contain posts that's authored by user1.
    assert_select "div.post", /#{@user1.name}/, count: 2
    assert_select "div.post", /^((?!#{@user2.name}).)*$/
  end

  test "Settings show my comments" do
    get settings_comments_path
    assert_template 'settings/comments'
    # Should only contain comments that's authored by user1.
    assert_select "div.comments", /#{@user1.name}/, count: 1
    assert_select "div.comments", /^((?!#{@user2.name}).)*$/
  end

  test "Settings show comments received." do
    get settings_receivedcomments_path
    assert_template 'settings/receivedcomments'
    # Should only contain comments from user2
    assert_select "div.comments", /#{@user2.name}/, count: 1
    assert_select "div.comments", /^((?!#{@user1.name}).)*$/
  end

  test "Settings my settings must show 4 links" do
    get edit_user_path(@user1)
    assert_select ".edit-user" do
      assert_select "a[href=?]", edit_user_path(@user1)
      assert_select "a[href=?]", edit_pass_path(@user1)
      assert_select "a[href=?]", edit_avatar_path(@user1)
      assert_select "a[href=?]", edit_card_path(@user1)
    end
  end

  test "Edit user details" do
    # Update with invalid details
    get user_path(@user1.id)
    # Details before updating
    assert_select ".user-info", /alex/
    assert_select ".user-info", /alex@hotmail.co.id/
    patch "/users/#{@user1.id}", params: { user: { name: '',
                                                  email: '',
                                                  mobile: '',
                                                  city: '',
                                                  info: '', } }
    assert_select "div#error_explanation"
    # Update with valid details
    patch "/users/#{@user1.id}", params: { user: { name: 'alex witedja',
                                                  email: 'alexwitedja@gmail.com',
                                                  mobile: '0987654321',
                                                  city: 'Melbourne',
                                                  info: 'RAD student', } }
    # Flash success is fileed
    assert_not flash[:success].empty?
    follow_redirect!
    # We can see that info is updated
    assert_select ".user-info", /alex witedja/
    assert_select ".user-info", /alexwitedja@gmail.com/
    # The email is not alex@hotmail.com anymore
    assert_select ".user-info", /^((?!alex@hotmail.com).)*$/
    assert_select ".user-info", /0987654321/
  end

  test "Edit password, logout and login with new password" do
    # Old password is password, check fixtures
    get edit_pass_path(@user1)
    patch "/users/#{@user1.id}/edit_pass", params: { user: { password: "123456", 
                                                            password_confirmation: "123456" } }
    # Flash success is fileed
    assert_not flash[:success].empty?
    follow_redirect!
    delete logout_path
    # Should be able to login with new password
    log_in_as(@user1, password: "123456", remember_me: '0')
    assert is_logged_in?
  end
end