require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "signup with invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username: "Karl", email: "tom@invalid",
                              zipcode: 12345,
                              password: "asdf123",
                              password_confirmation: "asdf123"
                            }
    end
    assert_template 'users/new'
    assert_select "div.error-explanation"
    assert_select "div.field_with_errors"
  end

  test "signup with valid information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: "Karl", email: "tom@valid.be",
                              zipcode: 12345,
                              password: "asdf123",
                              password_confirmation: "asdf123" }
    end
    assert is_logged_in?
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
