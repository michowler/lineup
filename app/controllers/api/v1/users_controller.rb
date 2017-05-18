class Api::V1::UsersController < Api::V1::ApplicationController

    # def update
    #     @user = User.find_by_id(params[:id])
    #     if @user.nil?  
    #         render status: 404, json: {error: "User not found"}
    #     else
    #         @user.update_attributes(params)
    #         render status: 200, json: => {message: "User has been updated"}
    #     end
    # end

    # def index
    #     users = Users.all
    #     render json: users
    # end
    def index
        render json: "hi"
    end

    def show
        user = User.where(private_token: params[:private_token]).first
        # user = user.to_json
        render json: user, status: :ok
    end
    
end

