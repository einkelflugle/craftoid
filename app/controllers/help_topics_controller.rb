class HelpTopicsController < ApplicationController
	before_action :signed_in_user, except: [:show, :index]
	before_action :admin_user, except: [:show, :index]

	def index
		@help_topics = HelpTopic.all
	end

	def show
		@help_topic = HelpTopic.friendly.find(params[:id])

		if request.path != help_topic_path(@help_topic)
			return redirect_to @help_topic, status: :moved_permanently
		end

		@help_topics = HelpTopic.all
	end

	def new
		@help_topic = HelpTopic.new
	end

	def create
		@help_topic = HelpTopic.create(help_topic_params)
		if @help_topic.save
			flash[:success] = "Successfully created #{@help_topic.title}."
			redirect_to @help_topic
		else
			render 'new'
		end
	end

	def edit
		@help_topic = HelpTopic.friendly.find(params[:id])
	end

	def update
		@help_topic = HelpTopic.friendly.find(params[:id])
		if @help_topic.update_attributes(help_topic_params)
			redirect_to @help_topic
		else
			render 'new'
		end
	end

	def destroy
		@help_topic = HelpTopic.friendly.find(params[:id])
		@help_topic.destroy
		redirect_to help_path
	end

	private
		def help_topic_params
			params.require(:help_topic).permit(:title, :body)
		end
end