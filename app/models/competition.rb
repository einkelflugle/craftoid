class Competition < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	has_many :robots, through: :entries
	has_and_belongs_to_many :categories
	belongs_to :user

	validates :name, presence: true, length: { minimum: 5, maximum: 50 }
	validates :description, presence: true, length: { minimum: 5, maximum: 2500 }

	include Viewable

	before_create :open_competition

	def self.most_entered
		Competition.all.sort_by { |competition| competition.entries.count }.reverse
	end

	def winner
		Robot.find(self.entries.sort_by { |entry| entry.votes }.reverse.first.robot_id)
	end

	private
		def open_competition
			self.open = true
		end
end