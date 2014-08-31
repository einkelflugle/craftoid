class Comment < ActiveRecord::Base
	belongs_to :robot
	belongs_to :user
	validates_presence_of :robot, :body

	validates :body, length: { minimum: 5, maximum: 60 }
end