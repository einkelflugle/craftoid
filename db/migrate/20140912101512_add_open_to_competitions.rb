class AddOpenToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :open, :boolean
  end
end
