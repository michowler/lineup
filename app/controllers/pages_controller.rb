class PagesController < ApplicationController
	def index
		if signed_in?
			if current_user.department == "Human Resource"
	      		redirect_to "/hr/dashboard"
	      	else
	        	redirect_to user_path(current_user)
	        end
	    end
	end

	def calendar
	end
end
