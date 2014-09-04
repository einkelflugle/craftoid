class Entry < ActiveRecord::Base
	belongs_to :robot
	belongs_to :competition
end