class TiersController < ApplicationController
	def show
		@tier = Tier.find_by(name: params[:name])
		@robots = Robot.where(tier_id: @tier.id)
	end
end