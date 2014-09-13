class RobotsController < ApplicationController
	include RobotsHelper

	before_action :signed_in_user, only: [:new, :create, :destroy, :edit, :update, :destroy]
	before_action :owns_robot, only: [:edit, :update, :destroy]

	def index
		@robots = Robot.reorder("created_at DESC").paginate(page: params[:page], per_page: 9)
	end

	def hot
		@robots = Robot.most_commented
	end

	def popular
		@robots = Robot.most_viewed
	end

	def show
		@robot = Robot.find(params[:id])
		@user = @robot.user
		@comments = @robot.comments
		@similar_robots = @robot.similar_robots.first(3)

		session[:viewed_robots] ||= []

		unless session[:viewed_robots].include?(@robot.id)
			@robot.add_one_view
			session[:viewed_robots] << @robot.id
		end
	end

	def edit
		@robot = Robot.find(params[:id])
	end

	def update
		@robot = Robot.find(params[:id])

		if @robot.update(robot_params)
			redirect_to @robot
		else
			render 'edit'
		end
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

	def destroy
		@robot = Robot.find(params[:id])
		@robot.destroy
		redirect_to robots_path
	end

	private
		def robot_params
			params.require(:robot).permit(:name, :description, :weapon_id, :tier_id, :screenshot_url, category_ids: [])
		end
end