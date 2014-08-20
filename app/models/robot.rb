class Robot < ActiveRecord::Base
	belongs_to :tier

	validates_presence_of :name, :description, :tier_id
	validates :name, length: {minimum: 5}

	validate :is_steam_url

	private
		def is_steam_url
			unless self.screenshot_url.include?(".steampowered.com")
				errors.add(:screenshot_url, "isn't valid.")
			end
		end
end
