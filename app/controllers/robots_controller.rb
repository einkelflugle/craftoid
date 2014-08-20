class RobotsController < ApplicationController

	def index
		@robots = Robot.all
	end

	def show
		@robot = Robot.find(params[:id])
	end

	def new
		@robot = Robot.new
	end

	def create
		@robot = Robot.new(robot_params)
		if @robot.save
			redirect_to @robot
		else
			render 'new'
		end
	end

	private
		def robot_params
			params.require(:robot).permit(:name, :description, :tier_id, :screenshot_url, category_ids: [])
		end
end