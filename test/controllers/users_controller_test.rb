require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  headers = {
    "ACCEPT" => "application/vnd.api+json",
    "CONTENT_TYPE" => "application/vnd.api+json"
  }

  test "should get index" do
    get users_url, {}, headers

    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      params = {
        data: {
          type: "users",
          attributes: {
            email: "ao@gmail.com",
            name: "Andy",
            password: "foo"
          }
        }
      }

      post users_url, params.to_json, headers
    end

    assert_response 201
  end

  test "should fail creating invalid user" do
    params = {
      data: {
        type: "users",
        attributes: { email: "", name: "" }
      }
    }
    post users_url, params.to_json, headers

    assert_response 422
  end

  test "should fail trying to create a user with same email" do
    user = users(:one)

    params = {
      data: {
        type: "users",
        attributes: { email: user.email, name: user.name }
      }
    }
    post users_url, params.to_json, headers

    assert_response 422
  end

  test "should show user" do
    user = users(:one)

    get user_url(user), {}, headers

    assert_response :success
  end

  test "should update user" do
    user = users(:one)

    params = {
      data: {
        id: user.id,
        type: "users",
        attributes: {
          email: "new@gmail.com",
          name: "Fred"
        }
      }
    }

    patch user_url(user), params.to_json, headers

    assert_response 200
  end

  test "should destroy user" do
    user = users(:one)

    assert_difference('User.count', -1) do
      delete user_url(user), {}, headers
    end

    assert_response 204
  end
end
