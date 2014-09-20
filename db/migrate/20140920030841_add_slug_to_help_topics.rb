class AddSlugToHelpTopics < ActiveRecord::Migration
  def change
    add_column :help_topics, :slug, :string
    add_index :help_topics, :slug
  end
end
