class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
    	t.belongs_to :robot
    	t.belongs_to :competition

    	t.integer :votes

    	t.timestamps
    end
  end
end
