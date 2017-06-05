class Api::V1::TotalLeavesController < Api::V1::ApplicationController

    # def total_leaves
        # user = User.where(private_token: params[:private_token]).first
        # remaining_leave = user.id

        # find_leave = find_leave.id
		# find_leave = User.find(find_leave).leaves 
        # annual = find_leave.where(leave_type: "0", status: "Approved").sum(:total_days).to_s
        # maternity = find_leave.where(leave_type: "1", status: "Approved").sum(:total_days).to_s
        # emergency = find_leave.where(leave_type: "2", status: "Approved").sum(:total_days).to_s
        # study = find_leave.where(leave_type: "3", status: "Approved").sum(:total_days).to_s
        # sick = find_leave.where(leave_type: "4", status: "Approved").sum(:total_days).to_s
        # non_paid = find_leave.where(leave_type: "5", status: "Approved").sum(:total_days).to_s
        # respond_to do |format|
        #     format.json { render :json => {:annual => annual, :maternity => maternity, :emergency => emergency, :study => study, :sick => sick, :non_paid => non_paid}}
        # end
    # end
    
end
