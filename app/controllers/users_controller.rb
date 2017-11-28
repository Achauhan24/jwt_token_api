class UsersController < ApplicationController
skip_before_action :authenticate_request, only: [:login,:create]
def show
user=User.find[:id]
render json: user
end

def login
authenticate params[:email],params[:password]
end
def test
render json:{message:"you have sucessfully passed authentication and authorization"}
end
	

def create
	@user=User.new(user_params)
	if @user.save
		render status: 200,json:{
			message: "successfully created",
			user: @user}
	else
		render json: @user.errors
	end
end




private
def user_params
	params.require(:user).permit(:email,:password,:password_confirmation)
end
 def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
   end

end
