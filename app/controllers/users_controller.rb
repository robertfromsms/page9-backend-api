# The three traditional routes are the login, user create and user update, all three hands back jwt.

class UsersController < ApplicationController
	skip_before_action :authenticate_request!, only: [:create]

	def create
	  	@user = User.new(user_params)
	  	if @user.save
	        auth_token = JsonWebToken.encode({user_id: @user.id})  
	    		render json: { user: UserSerializer.new(@user), message: 'User created successfully', jwt: auth_token },
	        	status: :created
	  	else
	    		render json: { errors: 'failed to create user' },
	          	status: :not_acceptable
	  	end
	 end

	 def update_current_user
	 	# this blocks checks whether an attribute has an update value
	 	@current_user.assign_attributes(full_name: user_params[:full_name]) if user_params[:full_name]
	 	@current_user.assign_attributes(password: user_params[:password]) if user_params[:password]
	 	@current_user.assign_attributes(address: user_params[:address]) if user_params[:address]
	 	@current_user.assign_attributes(email: user_params[:email]) if user_params[:email]

	 	if @current_user.save
	 		auth_token = JsonWebToken.encode({user_id: @current_user.id})
	 		render json: { user: UserSerializer.new(@current_user), message: 'User updated successfully', jwt: auth_token }
	 	else
	 		render json: { errors: 'failed to update user'},
	 		status: :not_acceptable
	 	end	
	 end

	private
  	def user_params
	  	params.require(:user)
      		.permit(
      			:user_name,
      			:full_name,
              	:password,
              	:password_confirmation,
              	:address,
              	:email
            )
  	end
end
