class ContactMessagesController < ApplicationController
	before_action :signed_in_user

	def create
		@contact_message = current_user.contact_messages.build(contact_message_params)
		@contact_message.save
		
		redirect_to root_url
	end

	private
		def contact_message_params
			params.require(:contact_message).permit(:message)
		end
end