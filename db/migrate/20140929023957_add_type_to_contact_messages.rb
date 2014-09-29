class AddTypeToContactMessages < ActiveRecord::Migration
  def change
  	add_column :contact_messages, :contact_type, :string
  end
end
