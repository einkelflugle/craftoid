class Category < ActiveRecord::Base
	has_and_belongs_to_many :robots
	has_and_belongs_to_many :competitions

	validates_presence_of :name, :description

	extend FriendlyId
	friendly_id :name, use: :history

	def should_generate_new_friendly_id?
		name_changed?
	end
end