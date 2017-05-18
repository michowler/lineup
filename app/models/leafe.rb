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

end
