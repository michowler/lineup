class Leafe < ApplicationRecord

	belongs_to :user

	enum leave_type: ["Annual", "Maternity", "Paternity", "Study", "Sick"]
	enum status: ["Pending","Approved","Rejected"]

end
