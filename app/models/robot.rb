class Robot < ActiveRecord::Base
	belongs_to :tier

	validates_presence_of :name, :description, :tier_id
	validates :name, length: {minimum: 5}
end
