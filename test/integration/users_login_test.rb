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

  test "login with valid information" do
    get login_path
    post login_path, session: {email: @user.email, password: 'das'}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end

end
