require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  headers = {
    "ACCEPT" => "application/vnd.api+json",
    "CONTENT_TYPE" => "application/vnd.api+json"
  }

  test "should get index" do
    get api_users_url, {}, headers

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

      post api_users_url, params.to_json, headers
    end

    assert_response 201
  end

  test "should fail creating invalid user" do
    params = {
      data: {
        type: "users",
        attributes: {
          email: "",
          name: ""
        }
      }
    }
    post api_users_url, params.to_json, headers

    assert_response 422
  end

  test "should fail trying to create a user with same email" do
    user = users(:one)

    params = {
      data: {
        type: "users",
        attributes: {
          email: user.email,
          name: user.name
        }
      }
    }
    post api_users_url, params.to_json, headers

    assert_response 422
  end

  test "should show user" do
    user = users(:one)

    get api_user_url(user), {}, headers

    assert_response :success
  end

  test "should destroy user" do
    user = users(:one)

    assert_difference('User.count', -1) do
      delete api_user_url(user), {}, headers
    end

    assert_response 204
  end

  test "timeline should include following tweets" do
    user = users(:one)

    get "/api/users/#{user.id}/timeline", {}, headers

    body = JSON.parse response.body

    assert_response :success
    assert_equal 3, body["data"].size
  end
end
