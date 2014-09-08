module Viewable
	extend ActiveSupport::Concern

	included do
		before_create :initialise_view_count
	end

	def add_one_view
		self.update_column(:views, views + 1)
	end

	def initialise_view_count
		self.views = 0
	end

	module ClassMethods
		def most_viewed
			self.all.sort_by { |item| item.views }.reverse
		end
	end
end