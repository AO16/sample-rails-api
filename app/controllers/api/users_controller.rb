class Api::UsersController < ApplicationController
  def login
    user = User.find_by(email: params[:username])

    return not_authorized unless user

    authenticated = user.authenticate(params['password'])

    return not_authorized unless authenticated

    render json: { access_token: user.api_key, user_id: user.id }
  end

  def timeline
    user = User.find(params[:id])

    followIds = user.followings.map { |follow| follow.id }
    followIds.push(user.id) unless followIds.include? user.id
    tweets = Tweet.where("user_id in (#{followIds.join(', ')})").order(created_at: :desc);

    tweetResources = tweets.map { |tweetResource| Api::TweetResource.new(tweetResource, nil) }
    serializedTweets = JSONAPI::ResourceSerializer.new(Api::TweetResource).serialize_to_hash(tweetResources)

    render json: serializedTweets
  end
end
