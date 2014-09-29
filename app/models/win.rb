class Win < ActiveRecord::Base
	belongs_to :competition
	belongs_to :robot
	belongs_to :user
end