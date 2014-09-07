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
end