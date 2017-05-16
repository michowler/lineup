class Leafe < ApplicationRecord
	belongs_to :user

	enum type: ["Annual", "Maternity", "Paternity", "Study", "Sick"]
	enum status: ["Pending","Approved","Rejected"]
end
