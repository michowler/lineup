class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :null_session
  
  
  if respond_to?(:before_action)
    before_action :login_required
  else
    before_filter :login_required
  end

  def login_required
  	permitted_path = ["/passwords/new","/sign_in","/passwords","/session","/"]
  	if !signed_in? 
  		redirect_to sign_in_path unless permitted_path.include?(request.fullpath)
  	end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def hr
    redirect_to "/" if current_user.department != "Human Resource"
  end

end
