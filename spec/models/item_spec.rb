# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pnl        :string(255)
#  date       :datetime
#  note       :string(255)
#  amount     :decimal(, )
#

require 'spec_helper'

describe Item do
	
	let( :item) { Item.create( :pnl => "expense") }

  it "has a type (pnl) - expense or income" do
		item.pnl.should == "expense"
		item.pnl = "income"
		item.pnl.should == "income"
	end

	it "has a non-empty note" do
		item.note.should be_nil
	end

	it "can create an income item with factory girl" do
		income = create( :income_item)
		income.should_not be_nil
		income.amount.should == 6000.0
	end

	it "can create an income item with factory girl" do
		expense = create( :expense_item)
		expense.amount.should == 450.0
		expense.note.should == "air tix to nj"
	end
end
