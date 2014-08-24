class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :robot, index: true
      t.text :body
    end
  end
end
