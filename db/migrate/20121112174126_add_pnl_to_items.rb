class AddPnlToItems < ActiveRecord::Migration
  def change
    add_column :items, :pnl, :string
  end
end
