class LeavesController < ApplicationController

	def index
		@leaves = Leafe.all.includes(:user)
	end

	def pending
		@leaves = Leafe.where(status: "Pending").where("start_date > ?",Time.now).order("start_date").includes(:user)
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

	def approve
		@leafe = Leafe.find(params[:id])
		@leafe.update(status: "Approved")
		flash[:success] = "Request Approved"
		redirect_to "/pending_leaves"
	end

	def reject
		@leafe = Leafe.find(params[:id])
		@leafe.update(reject_params)
		flash[:info] = "Request Rejected"
		redirect_to "/pending_leaves"
	end

	def details
		@leafe = Leafe.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

	private

	def create_params
		params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status,:total_days)
	end

	def reject_params
		params.permit(:status,:rejection_reason)
	end

end
