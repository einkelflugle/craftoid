class Entry < ActiveRecord::Base
	belongs_to :robot
	belongs_to :competition
	belongs_to :user

	before_create :initialise_vote_count

	def add_one_vote
		self.update_column(:votes, votes + 1)
	end

	private
		def initialise_vote_count
			self.votes = 0
		end
end