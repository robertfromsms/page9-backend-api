# One of the three traditional routes is the login, all three hands back jwt.

class AuthenticationController < ApplicationController
	skip_before_action :authenticate_request!, only: [:create]

	def create
		@user = User.find_by(user_name: params[:user][:user_name])

		if @user && @user.authenticate(params[:user][:password])
			auth_token = JsonWebToken.encode({user_id: @user.id})
			render json: {user: UserSerializer.new(@user), message: 'User logged-in successfully', jwt: auth_token}, status: :ok
		else
			render json: {error: "Login Unsuccessful"}, status: :unauthorized
		end
	end
end