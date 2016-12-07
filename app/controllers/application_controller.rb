class ApplicationController < JSONAPI::ResourceController
  private

  def not_authorized
    render json: { error: 'Not Authorized' }, status: 401
  end

  def authenticate_request
    @auth_header = request.headers['Authorization']

    return not_authorized unless @auth_header

    @user = User.find_by(email: params[:email])

    @authenticated = @user.authenticate(params['password'])
    return not_authorized unless @authenticated

    @current_user = @auth_header.split(' ').last
    not_authorized unless @current_user == @user.api_key
  end
end
