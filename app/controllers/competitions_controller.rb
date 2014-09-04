class CompetitionsController < ApplicationController
	
	before_action :signed_in_user, except: :index

	def index
		@competitions = Competition.all
	end

	def show
		@competition = Competition.find(params[:id])
	end

	def new
		@competition = Competition.new
	end

	def create
		@competition = Competition.new(competition_params)
		if @competition.save
			redirect_to @competition
		else
			render 'new'
		end
	end

	private
		def competition_params
			params.require(:competition).permit(:name, :description, category_ids: [])
		end
end