class CompetitionsController < ApplicationController
	include CompetitionsHelper
	
	before_action :signed_in_user, except: [:index, :hot, :popular, :show]
	before_action :owns_competition, only: [:edit, :update, :destroy]

	def index
		@competitions = Competition.reorder("created_at DESC").paginate(page: params[:page], per_page: 9)
	end

	def hot
		@competitions = Competition.most_entered
	end

	def popular
		@competitions = Competition.most_viewed
	end

	def show
		@competition = Competition.find(params[:id])
		@user = User.find(@competition.user_id)
		if signed_in?
			@enterable_robots = current_user.robots - @competition.robots
			@has_enterable_robots = !@enterable_robots.blank?
		end

		session[:viewed_competitions] ||= []

		unless session[:viewed_competitions].include?(@competition.id)
			@competition.add_one_view
			session[:viewed_competitions] << @competition.id
		end
	end

	def new
		@competition = Competition.new
	end

	def create
		@competition = current_user.competitions.build(competition_params)
		if @competition.save
			redirect_to @competition
		else
			render 'new'
		end
	end

	def edit
		@competition = Competition.find(params[:id])
	end

	def update
		@competition = Competition.find(params[:id])

		if @competition.update(competition_params)
			redirect_to @competition
		else
			render 'edit'
		end
	end

	def destroy
		@competition = Competition.find(params[:id])
		@competition.destroy
		redirect_to competitions_path
	end

	private
		def competition_params
			params.require(:competition).permit(:name, :description, category_ids: [])
		end
end