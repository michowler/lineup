class Api::V1::LeavesController < Api::V1::ApplicationController
    

    #send total up leave days to them.
    
    def create
        leafe = Leafe.new(create_params)
        leafe.user_id = current_user.id
        leafe.save
        leafe.update(total_days: leafe.weekdays)
        render json: {message: "Request sent"}
    end
    
    def show
        leaves = Leafe.where(private_token: params[:private_token])
        render json: leaves, status: :ok
    end

    #so they can update their leave request
    def update
    end
    
    # def approve
    #     leafe = Leafe.where(private_token: params[:private_token])
    #     leafe = leafe.update(status: "Approved")
    #     render json: leafe, status: :ok
    # end
    

    

	private
	def create_params
		current_params = params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status,:total_days)
        current_params[:start_date] = Time.zone.parse(params[:start_date])
        current_params[:end_date] = Time.zone.parse(params[:end_date])
        return current_params
	end
end
