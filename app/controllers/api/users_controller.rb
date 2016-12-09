class Api::UsersController < ApplicationController
  def login
    user = User.find_by(email: params[:username])

    return not_authorized unless user

    authenticated = user.authenticate(params['password'])

    return not_authorized unless authenticated

    render json: { access_token: user.api_key, user_id: user.id }
  end
end
