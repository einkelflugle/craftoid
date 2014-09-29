class Robot < ActiveRecord::Base
	belongs_to :tier
	belongs_to :user
	has_many :entries, dependent: :destroy
	has_many :competitions, through: :entries
	has_many :comments, dependent: :destroy
	has_many :wins, dependent: :destroy
	has_and_belongs_to_many :categories
	belongs_to :weapon

	VALID_STEAM_SCRENSHOT_REGEX = /http(s?):\/\/cloud(-[1-4])?.steampowered.com\/ugc\/.+\/.+\//i
	validates_presence_of :name, :description, :categories, :weapon, :screenshot_url, :user_id, :tier_id
	validates :name, length: { minimum: 5, maximum: 35 }
	validates :screenshot_url, format: { with: VALID_STEAM_SCRENSHOT_REGEX, message: " isn't a valid Steam screenshot." }

	include Viewable

	extend FriendlyId
	friendly_id :name, use: :history

	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end

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

	def competitions_won
		won = []
		Win.where(robot_id: self.id).each do |w|
			won << w.competition
		end
		won
	end

	def self.most_commented
		Robot.all.sort_by { |robot| robot.comments.count }.reverse
	end

	def self.most_favorited
		Robot.all.sort_by { |robot| robot.get_likes.size }.reverse
	end
end
