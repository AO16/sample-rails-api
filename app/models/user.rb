class User < ApplicationRecord
  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
