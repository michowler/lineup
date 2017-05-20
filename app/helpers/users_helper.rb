module UsersHelper

	def hr?
		if current_user.department == "Human Resource"
			true
		else
			false
		end
	end
end
