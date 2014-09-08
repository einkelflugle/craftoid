class EntriesController < ApplicationController
	before_action :signed_in_user

	def create
		@competition = Competition.find(params[:competition_id])
		@entry = @competition.entries.build(entry_params)
		if @entry.save
			redirect_to @competition
			flash[:success] = "Successfully entered #{@entry.robot.name}"
		else
			flash[:error] = "Try again."
		end
	end

	def vote
		@competition = Competition.find(params[:competition_id])
		@entry = Entry.find(params[:id])

		session[:voted_for_entries] ||= []

		if !session[:voted_for_entries].include?(@entry.id)
			@entry.add_one_vote
			session[:voted_for_entries] << @entry.id
		else
			flash[:error] = "You have already voted for this entry."
		end

		redirect_to @competition
	end

	private
		def entry_params
			params.require(:entry).permit(:competition_id, :robot_id)
		end
end