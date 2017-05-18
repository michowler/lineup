class Api::V1::LeavesController < Api::V1::ApplicationController
    
    
    def create
        leafe = Leafe.new(create_params)
        leafe.user_id = current_user.id
        leafe.save
        total_days = leafe.end_date.mjd - leafe.start_date.mjd+1
        leafe.update(total_days: total_days)
        render json: {message: "Request sent"}
    end
    

	private
	def create_params
		current_params = params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status,:total_days)
        current_params[:start_date] = Time.zone.parse(params[:start_date])
        current_params[:end_date] = Time.zone.parse(params[:end_date])
        return current_params
	end
end
