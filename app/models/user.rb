class User < ApplicationRecord
  before_create do |user| 
    @payload = { :user_id => user.id }

    user.api_key = JWT.encode @payload, 'secret_key', 'HS256'
  end

  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password

  has_many :tweets

  has_many :followers, :foreign_key => "follower_id", :class_name => "Follow"
  has_many :followings, :through => :followers
end
