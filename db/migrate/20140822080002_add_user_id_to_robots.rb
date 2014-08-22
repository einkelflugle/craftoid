class AddUserIdToRobots < ActiveRecord::Migration
  def change
    add_reference :robots, :user, index: true
  end
end
