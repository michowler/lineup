class Leafe < ApplicationRecord

	belongs_to :user

	enum leave_type: ["Annual", "Maternity", "Paternity", "Study", "Sick"]
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

end
