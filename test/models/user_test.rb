require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "example_user", email: "test@example.com",
                    zipcode: 12345,
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "username should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "zipcode should be present" do
    @user.zipcode = "  "
    assert_not @user.valid?
  end

  test "zipcode should be of length 5" do
    [4342,632462].each do |invalid_zip|
      @user.zipcode = invalid_zip
      assert_not @user.valid?, "#{invalid_zip} seems be valid"
    end
  end
end
