class Leafe < ApplicationRecord
	mount_uploader :image, LeaveUploader
	belongs_to :user

	enum leave_type: ["Annual", "Maternity", "Emergency", "Study", "Sick","Non_paid"]
	enum status: ["Pending","Approved","Rejected"]
	

	def self.approved_dates
		approved = []
		Leafe.where(status: "Approved").each do |leave|
			approved << (leave.start_date..leave.end_date).map(&:to_s)
		end
		approved.flatten.uniq if approved != []
	end

	def weekdays
		days = (self.start_date..self.end_date).map(&:wday)
		weekends = days.count(6)+days.count(0)
		total_days = self.end_date.mjd-self.start_date.mjd+1-weekends
	end

	def self.leaves_every_month
		month_leaves = Array.new(12,0)
		Leafe.where(status: "Approved").where('extract(year  from start_date) = ?', Date.today.year).group("DATE_TRUNC('month', start_date)").count.each do |key,value|
			month_leaves[key.month-1] = value
		end
		month_leaves
	end

	def has_remaining?
		remaining_leafe = self.user.remaining_leafe
		remaining_no = remaining_leafe.send(self.leave_type.downcase)
		if remaining_no-self.weekdays >= 0
			# remaining_leafe.update(self.leave_type.downcase.to_sym => (remaining_no-self.weekdays))
			return true
		else
			return false
		end
	end

	def deduct_leave
		
		remaining_leafe = self.user.remaining_leafe
		remaining_no = remaining_leafe.send(self.leave_type.downcase)
		remaining_leafe.update(self.leave_type.downcase.to_sym => (remaining_no-self.weekdays))
	end

end
