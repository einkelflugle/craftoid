class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]

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
		@comment.destroy

		redirect_to robot_path(@robot)
	end

	private
		def comment_params
			params.require(:comment).permit(:user, :robot, :body)
		end
end