class LeavesController < ApplicationController
	
	before_action :hr, only: [:index,:pending,:upcoming,:approve,:reject]

	skip_before_action :verify_authenticity_token, only: :update

	def index
		@leaves = Leafe.where("start_date < ?", Date.today).order("start_date DESC").includes(:user).paginate(:page => params[:page], :per_page => 5)
	end

	def pending
		@leaves = Leafe.where.not(status: "Approved").where("start_date >= ?", Date.today).order("start_date").includes(:user).paginate(:page => params[:page], :per_page => 5)
		session[:path] = request.fullpath
	end

	def upcoming
		@leaves = Leafe.where(status: "Approved").where("start_date >= ?", Date.today).order("start_date").includes(:user).paginate(:page => params[:page], :per_page => 5)
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
		if @leafe.has_remaining?
			@leafe.total_days = @leafe.weekdays
			@leafe.save
			flash[:success] = "Request submitted"
			redirect_to leafe_path(@leafe)
		else
			flash.now[:danger] = "Requested days has exceeded your remaining leaves"
			render "new"
		end
	end

	def edit
		@leafe = Leafe.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

	def update
		@leafe = Leafe.find(params[:id])
		@leafe.attributes = update_params
		if @leafe.has_remaining?
			@leafe.total_days = @leafe.weekdays
			@leafe.save
			flash[:success] = "Request Updated"
			redirect_to session[:path]
		else
			flash.now[:danger] = "Requested days has exceeded your remaining leaves"
			respond_to do |format|
				format.js
			end
		end
	end

	def approve
		@leafe = Leafe.find(params[:id])
		@leafe.update(status: "Approved")
		@leafe.deduct_leave
		flash[:success] = "Request Approved"
		redirect_to session[:path]
	end

	def reject
		@leafe = Leafe.find(params[:id])
		@leafe.update(reject_params)
		flash[:info] = "Request Rejected"
		redirect_to session[:path]
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

	def attachment
		@leafe = Leafe.find(params[:id])
		render "attachment", layout: false
	end

	def download
		@leafe = Leafe.find(params[:id])
		send_file @leafe.image.url, :x_sendfile=>true
	end
	
	private

	def create_params
		params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:user_id,:status,:total_days, :image)

	end

	def reject_params
		params.permit(:status,:rejection_reason)
	end

	def update_params
		params.require(:leafe).permit(:leave_type,:leave_reason,:start_date,:end_date,:status,:total_days, :image)
	end

end
