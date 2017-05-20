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
        user_leave = user
        user_leave = user_leave.id
		user_leave = User.find(user_leave).leaves 
        user_leave = user_leave.as_json(only: [:leave_type, :start_date, :end_date, :total_days, :status])
        # manager = User.where(manager_id: 1)
        # user = user.to_json
        respond_to do |format|
            format.json { render :json => {:user => user,
            :user_leave => user_leave}}
        # render json: user, status: :ok
        end
    end

    # def user_leaves
    #     user_leave = User.find(private_token: params[:private_token])
	# 	user_leave = User.find(params[:id]).leaves
    #     # user = user.leaves
    #     user_leave = user.pluck(:leave_type, :start_date, :end_date, :total_days).to_s
    #     return user
    #     render json: user_leave, status: :ok
    # end
    
end



