class Entry < ActiveRecord::Base
	belongs_to :robot, counter_cache: true
	belongs_to :competition, counter_cache: true
	belongs_to :user, counter_cache: true

	before_create :initialise_vote_count

	def add_one_vote
		self.update_column(:votes, votes + 1)
	end

	private
		def initialise_vote_count
			self.votes = 0
		end
end