class RobotsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :destroy]

	def index
		@robots = Robot.reorder("created_at DESC").paginate(page: params[:page], per_page: 9)
	end

	def hot
		@robots = Robot.all.sort_by { |bot| bot.comments.count }.reverse
	end

	def show
		@robot = Robot.find(params[:id])
		@user = @robot.user
		@comments = @robot.comments
		@similar_robots = @robot.similar_robots.first(3)
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