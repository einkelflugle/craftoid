class EntriesController < ApplicationController
	include EntriesHelper

	before_action :signed_in_user, except: [:index, :popular]
	before_action :owns_entry, only: [:destroy]

	def index
		@competition = Competition.find(params[:competition_id])
		@entries = @competition.entries.paginate(page: params[:page], per_page: 9)
	end

	def popular
		@competition = Competition.find(params[:competition_id])
		@entries = @competition.entries.paginate(page: params[:page], per_page: 9).sort_by { |e| e.votes }.reverse
	end

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

	def destroy
		@competition = Competition.find(params[:competition_id])
		@entry = Entry.find(params[:id])
		@entry.destroy
		redirect_to @competition
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