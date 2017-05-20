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
    # def index
    #     render json: "hi"
    # end

    #NEED TO DO manager name
    def show
        user = User.where(private_token: params[:private_token]).first
        # manager = User.where(manager_id: 1)
        # user = user.to_json
        # respond_to do |format|
        #     format.json { render :json => {:user => user,
        #     :manager_name => manager_name}}
        render json: user, status: :ok
        # end
    end

    def user_leaves
        # user = User.where(private_token: params[:private_token])
		user = User.find(params[:id]).leaves
        # user = user.leaves
        user = user.pluck(:leave_type, :start_date, :end_date, :total_days)
        return user
        render json: user, status: :ok
    end
    
end

