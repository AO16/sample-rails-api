require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user is fails validation if missing name and email" do
    @user = users(:empty)

    assert_not @user.valid?
  end

  test "user email must be unique" do
    @user = users(:two)
    @dup_user = users(:two_dup)

    @user.save

    assert_not @dup_user.valid?
  end

  test "user email must be an email" do
    @user = users(:invalid_email)

    assert_not @user.valid?
  end

  test "user is valid with name, password and email" do
    user = User.new(name: "Andy", email: "ao@gmail.com", password: "foo")
    assert user.valid?
  end
end
