class TiersController < ApplicationController
	def show
		@robots = Robot.where(tier_id: params[:id])
	end
end