require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  headers = {
    "ACCEPT" => "application/vnd.api+json",
    "CONTENT_TYPE" => "application/vnd.api+json"
  }

  test "can create tweet" do
    assert_difference('Tweet.count') do
      user = users(:one)

      params = {
        data: {
          type: "tweets",
          attributes: {
            text: "hai"
          },
          relationships: {
            user: {
              data: {
                type: "users",
                id: user.id
              }
            }
          }
        }
      }

      post api_tweets_url, params.to_json, headers
    end

    assert_response 201
  end
end
