class CategoriesController < ApplicationController
	def show
		@category = Category.find(params[:id])
		@robots = @category.robots
	end
end