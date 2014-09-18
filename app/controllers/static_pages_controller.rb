class StaticPagesController < ApplicationController
	def help
		@help_topics = HelpTopic.all
	end
end