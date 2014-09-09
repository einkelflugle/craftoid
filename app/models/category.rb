class Category < ActiveRecord::Base
	has_and_belongs_to_many :robots
	has_and_belongs_to_many :competitions
end