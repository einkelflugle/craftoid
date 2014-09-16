class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(name: params[:session][:name].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			flash[:success] = "You have been signed in."
			redirect_back_or user
		else
			flash.now[:error] = "Invalid email/password combination."
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to robots_path
		reset_session
	end
end