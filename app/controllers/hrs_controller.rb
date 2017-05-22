class HrsController < ApplicationController

	def dashboard
		session[:path] = request.fullpath
	end

	def statistics
	end
	
end
