class HrsController < ApplicationController

	def dashboard
		session[:path] = request.fullpath
	end

	
end
