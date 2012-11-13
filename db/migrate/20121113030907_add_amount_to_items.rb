class AddAmountToItems < ActiveRecord::Migration
  def change
    add_column :items, :amount, :decimal
  end
end
