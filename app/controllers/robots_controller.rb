class RobotsController < ApplicationController
	include RobotsHelper

	before_action :signed_in_user, except: [:index, :popular, :hot, :show]
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

	def favorited
		@robots = Robot.most_favorited
	end

	def show
		@robot = Robot.friendly.find(params[:id])

		if request.path != robot_path(@robot)
			return redirect_to @robot, status: :moved_permanently
		end

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
		@robot = Robot.friendly.find(params[:id])
	end

	def update
		@robot = Robot.friendly.find(params[:id])

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
		@robot = Robot.friendly.find(params[:id])
		@robot.destroy
		redirect_to robots_path
	end

	def favorite
		@robot = Robot.friendly.find(params[:id])
		if current_user.voted_for? @robot
			@robot.unliked_by current_user
			flash[:success] = "Removed #{@robot.name} from your favorites."
		else
			@robot.liked_by current_user
			flash[:success] = "Added #{@robot.name} to your favorites."
		end
		redirect_to @robot
	end

	private
		def robot_params
			params.require(:robot).permit(:name, :description, :weapon_id, :tier_id, :screenshot_url, category_ids: [])
		end
end