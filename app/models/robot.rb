class Robot < ActiveRecord::Base
	belongs_to :tier
	belongs_to :user
	has_many :entries, dependent: :destroy
	has_many :competitions, through: :entries
	has_many :comments, dependent: :destroy
	has_and_belongs_to_many :categories
	belongs_to :weapon

	validates_presence_of :name, :description, :categories, :weapon, :user_id, :tier_id
	validates :name, length: {minimum: 5}
	validate :is_steam_url

	include Viewable

	acts_as_votable

	def similar_robots(minimum_similar_categories = 1)
		matches = [] # Gets set to an array of robot objects
		Robot.all.each do |robot|
			categories_in_common = self.categories & robot.categories # array of similar categories
			if categories_in_common.length >= minimum_similar_categories
				unless self == robot
					matches << robot
				end
			end
		end
		matches
	end

	def self.most_commented
		Robot.all.sort_by { |robot| robot.comments.count }.reverse
	end

	private
		def is_steam_url
			unless self.screenshot_url.include?(".steampowered.com")
				errors.add(:screenshot_url, "isn't valid.")
			end
		end
end
