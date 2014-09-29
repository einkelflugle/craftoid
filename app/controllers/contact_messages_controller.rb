class ContactMessagesController < ApplicationController
	before_action :signed_in_user

	def create
		@contact_message = current_user.contact_messages.build(contact_message_params)
		@contact_message.save
		flash[:success] = "Thanks for your feedback. We will get back to you as soon as possible."
		
		redirect_to root_url
	end

	private
		def contact_message_params
			params.require(:contact_message).permit(:message, :contact_type)
		end
end