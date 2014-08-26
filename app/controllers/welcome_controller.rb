class WelcomeController < ApplicationController
	before_action :signed_in
	layout 'welcome'

	def index
		
	end

	private
		def signed_in
			if signed_in?
				redirect_to robots_path
			end
		end
end