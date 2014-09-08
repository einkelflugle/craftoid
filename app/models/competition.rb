class Competition < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	has_many :robots, through: :entries
	belongs_to :user

	validates :name, presence: true, length: { minimum: 5, maximum: 30 }
	validates :description, presence: true, length: { minimum: 5, maximum: 2500 }

	include Viewable

	def self.most_entered
		Competition.all.sort_by { |competition| competition.entries.count }.reverse
	end
end