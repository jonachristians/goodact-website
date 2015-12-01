require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:asd)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "afd@asd.com", password: "afsdafs"}
    assert_template 'sessions/new'
    assert flash.any?
    get root_path
    assert flash.empty?, "Flash should be empty"
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: {email: @user.email, password: 'das'}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert flash.any?
    assert_select "a[href=?]", login_path, false
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert flash.any?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, false
    assert_select "a[href=?]", user_path(@user), false
  end

end
