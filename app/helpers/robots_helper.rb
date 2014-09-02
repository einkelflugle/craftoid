module RobotsHelper
	def owns_robot
		@robot = Robot.find(params[:id])
		unless current_user == @robot.user || admin?(current_user)
			store_location
			flash[:error] = "You cannot edit this robot."
			redirect_to robots_path
		end
	end
end