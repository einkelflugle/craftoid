class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
    	t.string :name
    	t.text :description

    	t.integer :views

    	t.timestamps
    end
  end
end
