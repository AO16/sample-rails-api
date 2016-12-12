class Api::FollowResource < JSONAPI::Resource
  has_one :follower, foreign_key: 'follower_id', class_name: 'User'
  has_one :following, foreign_key: 'following_id', class_name: 'User'
end
