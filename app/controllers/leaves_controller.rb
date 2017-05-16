class LeavesController < ApplicationController

	def index
	end

	def show
	end

	def new
		@leafe = Leafe.new
	end

	def create

	end

	def update
	end

	def edit
	end

	private

	def create_params
		params.require(:leafe).permit(:leave_type,:reason,:start_date,:end_date,:user_id,:status)
	end

end
