class CreateHelpTopics < ActiveRecord::Migration
  def change
    create_table :help_topics do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
