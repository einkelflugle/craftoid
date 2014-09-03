class TiersController < ApplicationController
	def index
		@tiers = Tier.all
	end

	def show
		@tier = Tier.find_by(name: params[:name])
		@robots = Robot.where(tier_id: @tier.id)
	end
end