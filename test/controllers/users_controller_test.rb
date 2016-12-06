require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    @user = users(:one)

    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: "ao@gmail.com", name: "Andy" } }, as: :json
    end

    assert_response 201
  end

  test "should fail creating invalid user" do
    post users_url, params: { user: { email: "", name: "" } }, as: :json

    assert_response 422
  end

  test "should fail trying to create a user with same email" do
    @user = users(:one)

    post users_url, params: { user: { email: @user.email, name: @user.name } }, as: :json

    assert_response 422
  end

  test "should show user" do
    @user = users(:one)

    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    @user = users(:one)

    patch user_url(@user), params: { user: { email: @user.email, name: @user.name } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    @user = users(:one)

    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
