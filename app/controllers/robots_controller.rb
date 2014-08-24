class RobotsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :destroy]

	def index
		@robots = Robot.all
	end

	def show
		@robot = Robot.find(params[:id])
		@user = @robot.user
		@comments = @robot.comments
	end

	def new
		@robot = Robot.new
	end

	def create
		@robot = current_user.robots.build(robot_params)
		if @robot.save
			flash[:success] = "Your robot was successfully created"
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