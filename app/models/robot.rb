class Robot < ActiveRecord::Base
	belongs_to :tier
	belongs_to :user
	has_many :comments
	has_and_belongs_to_many :categories

	validates_presence_of :name, :description, :categories, :user_id, :tier_id
	validates :name, length: {minimum: 5}

	validate :is_steam_url

	private
		def is_steam_url
			unless self.screenshot_url.include?(".steampowered.com")
				errors.add(:screenshot_url, "isn't valid.")
			end
		end
end
