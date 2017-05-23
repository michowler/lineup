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

    def show
        user = User.where(private_token: params[:private_token]).first
        current_user = user
        user_avatar = current_user
        user_avatar["avatar"] = user_avatar.avatar.url
        user_avatar = user_avatar
        user_id = current_user.id
        manager_id = current_user.manager_id
        manager_name = User.find(manager_id)
        manager_name = manager_name.as_json(only: [:name])
		user_leave = User.find(user_id).leaves(:start_date)
        user_leave = user_leave.as_json(only: [:id, :leave_type, :start_date, :end_date, :total_days, :status])
        remaining_leaves = RemainingLeafe.find(user_id)
        # remaining_leaves = remaining_leaves
        remaining_leaves = remaining_leaves.as_json(only: [:annual, :maternity, :emergency, :study, :sick, :non_paid])
        # return remaining_leaves

        # user = user.to_json
        respond_to do |format|
            format.json { render :json => {:user => user, :manager_name => manager_name,
            :user_leave => user_leave, :user_avatar => user_avatar, :remaining_leaves => remaining_leaves}}
        # render json: user, status: :ok
        end
    end

end



