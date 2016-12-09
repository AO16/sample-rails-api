class TweetResource < JSONAPI::Resource
  attributes :text
  has_one :user, foreign_key: 'user_id', class_name: 'User'
end
