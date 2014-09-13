class AddShortNameToWeapons < ActiveRecord::Migration
  def change
    add_column :weapons, :short_name, :string
  end
end
