class AddViewsToRobots < ActiveRecord::Migration
  def change
  	add_column :robots, :views, :integer
  end
end
