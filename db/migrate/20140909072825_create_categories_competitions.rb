class CreateCategoriesCompetitions < ActiveRecord::Migration
  def change
    create_table :categories_competitions, id: false do |t|
    	t.belongs_to :category
    	t.belongs_to :competition
    end
  end
end
