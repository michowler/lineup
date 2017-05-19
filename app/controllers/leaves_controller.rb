class LeavesController < ApplicationController

	def index
		@leaves = Leafe.where("start_date <= ?", Date.today).order("start_date DESC").includes(:user)
	end

	def pending
		@leaves = Leafe.where.not(status: "Approved").where("start_date >= ?", Date.today).order("start_date").includes(:user)
		session[:path] = request.fullpath
	end

	def upcoming
		@leaves = Leafe.where(status: "Approved").where("start_date >= ?", Date.today).order("start_date").includes(:user)
		session[:path] = request.fullpath
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
		@leafe.update(total_days: @leafe.weekdays)
		flash[:success] = "Request submitted"
		redirect_to leafe_path(@leafe)
	end

	def edit
		@leafe = Leafe.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

	def update
		@leafe = Leafe.find(params[:id])
		@leafe.update(update_params)
		@leafe.update(total_days: @leafe.weekdays)
		flash[:success] = "Request Updated"
		redirect_to session[:path]
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

	def destroy
		@leafe = Leafe.find(params[:id])
		@leafe.destroy
	end
	
	private

	def create_params
		params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status,:total_days, {images: []})

	end

	def reject_params
		params.permit(:status,:rejection_reason)
	end

	def update_params
		params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:status,:total_days, {images: []})
	end

end
