class UsersController < ApplicationController

	before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user, 	   only: [:destroy]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
		@username = @user.name
		@robots = @user.robots
		@comments = @user.comments.reverse
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to RoboRails!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile successfully updated."
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to users_path
	end

	def robots
		@user = User.find(params[:id])
		@robots = Robot.where(user_id: @user.id).most_commented
	end

	def competitions
		@user = User.find(params[:id])
		@competitions = Competition.where(user_id: @user.id).sort_by { |competition| competition.entries.count }.reverse
	end

	def entries
		@user = User.find(params[:id])
		@entries = @user.robots.entries
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end