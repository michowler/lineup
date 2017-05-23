class SessionsController < Clearance::SessionsController
	before_action :redirect, only: :new

	  def create
	    @user = authenticate(params)

	    sign_in(@user) do |status|
	      if status.success?
	      	if current_user.department == "Human Resource"
	      		redirect_to "/hr/dashboard"
	      	else
	        	redirect_to user_path(current_user)
	        end
	      else
	        flash.now.notice = status.failure_message
	        render template: "sessions/new", status: :unauthorized
	      end
	    end
	  end

	 	def destroy
		    sign_out
		    redirect_to "/"
		end

		def redirect
			redirect_to '/' if request.fullpath == "/sign_in"
		end

end