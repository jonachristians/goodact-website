require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # in order to see why user is not valid:
    # @user.errors.full_messages.each do |msg|
    #   puts msg
    # end
  # use in an test you like
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

  test "username should not be longer than 30 chars" do
    @user.username = "a"*31
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be saved lowercase" do
    mixed_case_email = "ExaMPLE@test.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "email should not be longer than 255 chars" do
    @user.email = "a"*244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should not accept invalid addresses" do
    invalid_adresses = %w(user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com)
    invalid_adresses.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} was falsly accepted"
    end
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w(user@example.com USER@foo.de A-Use.r@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} was falsly denied"
    end
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

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "       "
    assert_not @user.valid?
  end

  test "password confirmation should match" do
    @user.password = "asdf"
    @user.password_confirmation = "fdsa"
    assert_not @user.valid?
  end

  test "authenticated? method should return false if remember_digest is nil" do
    assert_not @user.authenticated?("")
  end
end
