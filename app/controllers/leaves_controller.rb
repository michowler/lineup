class LeavesController < ApplicationController

	def index
	end

	def show
		@leafe = Leafe.find(params[:id])
	end

	def new
		@leafe = Leafe.new
	end

	def create
		@leafe = Leafe.new(create_params)
		@leafe.save
		total_days = @leafe.end_date.mjd-@leafe.start_date.mjd+1
		@leafe.update(total_days: total_days)
		flash[:success] = "Request submitted"
		redirect_to leafe_path(@leafe)
	end

	def update
	end

	def edit
	end

	private

	def create_params
		params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status)
	end

end
