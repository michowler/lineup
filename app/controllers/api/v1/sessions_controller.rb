class Api::V1::SessionsController < Api::V1::ApplicationController

    skip_before_action :check_authorization
    
    
    def create
        email, password = session_params.values_at("email", "password")
        user = User.authenticate(email, password)
        if user
            render json: {private_token: user.private_token}
        else
            render status: 403, json: {error: "Wrong email or password"}
        end
    end

    # def destroy
    #     @user = current_user.find_by([:session][:private_token])
    #     if @user
    #         sign_out
    #         render json: {status: :success}
    #     else
    #         render json: {error: "Could not find user to log out."}
    # end
    

    private
    def session_params
        params.permit(:email, :password)
    end

end
