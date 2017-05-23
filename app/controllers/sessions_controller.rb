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
	        flash.now[:danger] = "Incorrect email or password"
	        respond_to do |format|
	        	format.js
	        end
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