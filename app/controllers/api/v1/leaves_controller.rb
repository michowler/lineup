class Api::V1::LeavesController < Api::V1::ApplicationController
    
    def create
        leafe = Leafe.new(create_params)
        leafe.remote_image_url = create_params[:image]
        leafe.user_id = current_user.id
        # create_params[:image] = leafe.remote_image_url 
        if leafe.has_remaining?
			leafe.total_days = leafe.weekdays
            leafe.status = leafe.update(status: "Pending")
			leafe.save
			render json: {message: "Request sent"}
        else
            render json: {message: "Requested days has exceeded"}
        end
    end
    
    def destroy
        leafe = Leafe.find(params[:id])
        leafe.destroy
    end
    
    

	private
	def create_params
		current_params = params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status,:total_days,:image)
        current_params[:start_date] = Time.zone.parse(params[:start_date])
        current_params[:end_date] = Time.zone.parse(params[:end_date])
        return current_params
	end

    
end
