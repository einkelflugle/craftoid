class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.references :user, index: true
      t.text :message
    end
  end
end
