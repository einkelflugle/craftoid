class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	include CommentsHelper

	def create
		@robot = Robot.find(params[:robot_id])
		@user = current_user
		@comment = current_user.comments.build(comment_params)
		@robot.comments << @comment

		redirect_to robot_path(@robot)
	end

	def destroy
		@robot = Robot.find(params[:robot_id])
		@comment = @robot.comments.find(params[:id])
		if owns_comment(current_user, @comment)
			@comment.destroy
		else
			flash[:error] = "You cannot delete this comment."
		end

		redirect_to robot_path(@robot)
	end

	private
		def comment_params
			params.require(:comment).permit(:user, :robot, :body)
		end
end