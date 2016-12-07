class UsersController < ApplicationController
  def login
    @user = User.find_by(email: params[:email])
    @authenticated = @user.authenticate(params['password'])

    return not_authorized unless @authenticated

    render json: { access_token: @user.api_key }
  end
end
