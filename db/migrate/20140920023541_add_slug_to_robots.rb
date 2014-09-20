class AddSlugToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :slug, :string
    add_index :robots, :slug
  end
end
