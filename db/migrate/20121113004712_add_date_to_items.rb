class AddDateToItems < ActiveRecord::Migration
  def change
    add_column :items, :date, :datetime
  end
end
