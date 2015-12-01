require 'test_helper'

class RememberRequestedUrlTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:asd)
  end

  test "remember requested url if visiting an restriced site" do
    restricted_url_to_request = users_path # can be any restriced site
    get restricted_url_to_request
    assert flash[:requested_url] == restricted_url_to_request,
      "Requested_url was expected to be #{restricted_url_to_request} but was #{flash[:requested_url]}"
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: "das"}
    assert_redirected_to restricted_url_to_request
    follow_redirect!
    assert flash[:requested_url] == nil, "flash[:requested_url] should be nil after log in"
  end

  test "redirect to user profile after directly logging in without visting restricted site" do
    get login_path
    assert flash[:requested_url] == nil, "flash[:requested_url] is not nil"
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: "das"}
    assert flash[:requested_url] == nil, "flash[:requested_url] is not nil"
    assert_redirected_to @user
  end

  test "do not save requested_url if visting an unrestricted site" do
    unrestricted_url = root_path # can be any unrestricted site
    get unrestricted_url
    assert flash[:requested_url] == nil, "flash[:requested_url] is not nil"
  end
end
