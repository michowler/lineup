class PasswordsController < Clearance::PasswordsController

	def change
		@user = current_user
	end

	def update_password
		user = User.find(params[:user_id])
		if user = User.authenticate(user.email,params[:original_password])
			if user.update(password: params[:password],password_confirmation: params[:password_confirmation])
				flash[:success] = "Password updated"
				redirect_to user_path(user)
			elsif user.email == "admin"
				user.attributes = {password: params[:password],password_confirmation: params[:password_confirmation]}
				user.save(validate: false)
				flash[:success] = "Profile updated"
				redirect_to user_path(user)
			else
				flash.now[:danger] = user.errors.full_messages.first
				render "change_password"
			end
		else
			flash.now[:danger] = "Incorrect password"
			render "change_password"
		end
	end

end