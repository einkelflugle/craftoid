class Competition < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	has_many :robots, through: :entries

	validates :name, presence: true, length: { minimum: 5, maximum: 30 }
	validates :description, presence: true, length: { minimum: 5 }
end