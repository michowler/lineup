require 'active_support/deprecation'

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

  def create
    if user = find_user_for_create
      user.forgot_password!
      UserMailer.change_password(user).deliver
      flash.now[:info] = "Please check your email for the instructions"
      render template: 'passwords/new'
    else
      flash.now[:info] = "Email not found"
      render template: 'passwords/new'
    end 
  end

  def edit
    @user = find_user_for_edit
    if params[:token]
      render template: 'passwords/edit'
    end
  end

  def new
    render template: 'passwords/new'
  end

  def update
    @user = find_user_for_update
    if @user.update_password password_reset_params
      sign_in @user
      redirect_to url_after_update
      session[:password_reset_token] = nil
    elsif @user.email == "admin"
        @user.attributes = {password: params[:password],password_confirmation: params[:password_confirmation]}
        @user.save(validate: false)
        sign_in @user
        redirect_to url_after_update
    else
      flash_failure_after_update
      render template: 'passwords/edit'
    end
  end

  private

  def deliver_email(user)
    mail = ::ClearanceMailer.change_password(user)

    if mail.respond_to?(:deliver_later)
      mail.deliver_later
    else
      mail.deliver
    end
  end

  def password_reset_params
    if params.has_key? :user
      ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
      params[:user][:password]
    else
      params[:password_reset][:password]
    end
  end

  def find_user_by_id_and_confirmation_token
    user_param = Clearance.configuration.user_id_parameter
    token = session[:password_reset_token] || params[:token]
    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token params[user_param], token.to_s
  end

  def find_user_for_create
    Clearance.configuration.user_model.
      find_by_normalized_email params[:password][:email]
  end

  def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

  def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

  def ensure_existing_user
    user=User.find(params[:user_id])
    unless user.confirmation_token == params[:token]
      flash_failure_when_forbidden
      render template: "passwords/new"
    end
  end

  def flash_failure_when_forbidden
    flash.now[:danger] = translate(:forbidden,
      scope: [:clearance, :controllers, :passwords],
      default: t('flashes.failure_when_forbidden'))
  end

  def flash_failure_after_update
    flash.now[:danger] = translate(:blank_password,
      scope: [:clearance, :controllers, :passwords],
      default: t('flashes.failure_after_update'))
  end

  def url_after_create
    sign_in_url
  end

  def url_after_update
    Clearance.configuration.redirect_url
  end
end
