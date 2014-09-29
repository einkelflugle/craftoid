class ContactMessage < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :message, :contact_type
end