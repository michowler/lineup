class HrsController < ApplicationController
	before_action :hr, only: [:dashboard,:statistics]
	def dashboard
		session[:path] = request.fullpath
	end

	def statistics
	end
	
end
