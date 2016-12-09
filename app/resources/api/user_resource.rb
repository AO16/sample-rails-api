module Api
  class UserResource < JSONAPI::Resource
    attributes :name, :email, :password
    has_many :tweets, always_include_linkage_data: true
    def fetchable_fields
      super - [:password]
    end
  end
end
