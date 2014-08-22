class UsersController < ApplicationController

	before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user, 	   only: [:destroy]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
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

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Filter out users who aren't signed in
		def signed_in_user
			unless signed_in?
				store_location
				flash[:notice] = "Please sign in."
				redirect_to signin_path
			end
		end

		# Make sure it's the right user trying to edit a profile
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		# Confirm the user performing an action is an admin
		def admin_user
			redirect_to users_path unless current_user.admin?
		end
end