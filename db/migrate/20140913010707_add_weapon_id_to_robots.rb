class AddWeaponIdToRobots < ActiveRecord::Migration
  def change
    add_reference :robots, :weapon, index: true
  end
end
