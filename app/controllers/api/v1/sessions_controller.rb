class Api::V1::SessionsController < ApplicationController

    skip_before_action :check_authorization
    
    def create
        email, password = session_params.values_at("email", "password")
        user = User.authenticate!(email, password)
        if user
            render json: {private_token: user.private_token}
        else
            render status: 403, json: {error: "Wrong email or password"}
        end
    end

    private
    def session_params
        params.permit(:email, :password)
    end

end
