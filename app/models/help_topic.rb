class HelpTopic < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true, length: { minimum: 20 }

	extend FriendlyId
	friendly_id :title, use: :history

	def should_generate_new_friendly_id?
		slug.blank? || title_changed?
	end
end