class HelpTopicsController < ApplicationController
	before_action :signed_in_user, except: :show
	before_action :admin_user, except: :show

	def show
		@help_topic = HelpTopic.find(params[:id])
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

	private
		def help_topic_params
			params.require(:help_topic).permit(:title, :body)
		end
end