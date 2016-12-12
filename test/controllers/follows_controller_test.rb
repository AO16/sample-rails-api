require 'test_helper'

class FollowsControllerTest < ActionDispatch::IntegrationTest
  headers = {
    "ACCEPT" => "application/vnd.api+json",
    "CONTENT_TYPE" => "application/vnd.api+json"
  }

  test "can create follow" do
    assert_difference('Follow.count') do
      user = users(:one)

      params = {
        data: {
          type: "follows",
          relationships: {
            follower: {
              data: {
                type: "users",
                id: user.id
              }
            },
            following: {
              data: {
                type: "users",
                id: user.id
              }
            }
          }
        }
      }

      post api_follows_url, params.to_json, headers
    end

    assert_response 201
  end
end
