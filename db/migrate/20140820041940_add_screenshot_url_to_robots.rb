class AddScreenshotUrlToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :screenshot_url, :string
  end
end
