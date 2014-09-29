class AddCounts < ActiveRecord::Migration
  def up
  	add_column :robots, :entries_count, :integer, default: 0
  	add_column :competitions, :entries_count, :integer, default: 0
  	add_column :users, :entries_count, :integer, default: 0

  	Robot.all.each do |robot|
  		Robot.reset_counters robot.id, :entries
  	end

  	Competition.all.each do |competition|
  		Competition.reset_counters competition.id, :entries
  	end

  	User.all.each do |user|
  		User.reset_counters user.id, :entries
  	end
  end

  def down
  	remove_column :robots, :entries_count
  	remove_column :competitions, :entries_count
  	remove_column :users, :entries_count
  end
end
