class TiersController < ApplicationController
	def show
		@tier = params[:id]
		@robots = Robot.where(tier_id: @tier)
	end
end