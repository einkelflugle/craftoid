class CreateCategoriesRobots < ActiveRecord::Migration
  def change
    create_table :categories_robots, id: false do |t|
    	t.belongs_to :category
    	t.belongs_to :robot
    end
  end
end
