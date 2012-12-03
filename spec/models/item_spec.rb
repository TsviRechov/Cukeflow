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
end
