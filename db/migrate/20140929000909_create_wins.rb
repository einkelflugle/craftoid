class CreateWins < ActiveRecord::Migration
  def change
    create_table :wins do |t|
      t.references :robot, index: true
      t.references :competition, index: true
      t.references :user, index: true
      t.integer :votes

      t.timestamps
    end
  end
end
