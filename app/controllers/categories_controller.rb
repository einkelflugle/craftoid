class CategoriesController < ApplicationController
	before_action :signed_in_user, except: :show
	before_action :admin_user, except: :show

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to @category
		else
			render 'new'
		end
	end

	def show
		@category = Category.friendly.find(params[:id])

		if request.path != category_path(@category)
			return redirect_to @category, status: :moved_permanently
		end

		@robots = @category.robots
	end

	def edit
		@category = Category.friendly.find(params[:id])
	end

	def update
		@category = Category.friendly.find(params[:id])
		if @category.save
			redirect_to @category
		else
			render 'new'
		end
	end

	private
		def category_params
			params.require(:category).permit(:name, :description)
		end
end