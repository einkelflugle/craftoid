module RobotsHelper
	def owns_robot
		@robot = Robot.friendly.find(params[:id])
		unless current_user == @robot.user || admin?(current_user)
			store_location
			flash[:error] = "You cannot modify this robot."
			redirect_to robots_path
		end
	end
end