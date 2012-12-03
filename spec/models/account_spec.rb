# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Account do
  before :all do
		@account = create( :account ) # factory girl! with has_many to items

		@t0, @t1 = "November 9, 2012", "November 11, 2012"
		@beginning = Date.parse( @t0).to_time
		@ending = Date.parse( @t1).to_time
		@filtered_items = @account.items_date_range( @beginning, @ending)
	end

	after :all do
		Account.destroy_all; Item.destroy_all
	end

	it "created an account with factory girl and it is not nil" do
		@account.should_not be_nil
		@account.name.should == "Tsvi Bar-David"
	end

	it "can create an account with items" do
		@account.items.count.should == 4
		@account.items.map { |i| i.formatted_date }.should == [
			"October 15, 2012", "October 11, 2012", "November 10, 2012", "November 10, 2012" 
		]
		@account.items.map { |i| i.pnl }.should == [
			"income", "expense", "income", "expense"
		]
		@account.items.map { |i| i.amount }.should == [
			3000.0, 1100.0, 6000.0, 450.0
		]
	end
	
	it "can create a date range" do
		@beginning.strftime( "%B %-d, %Y" ).should == @t0
		@ending.strftime( "%B %-d, %Y" ).should == @t1
	end

	it "can filter account items on a date range" do
		@filtered_items.map { |i|
			[ i.pnl, i.amount.to_s( "F") ]
		}.should == [["income", "6000.0"], ["expense", "450.0"]]
	end

	it "can calculate total income over a date range" do
		@account.total_income( @beginning, @ending).should == 6000.0
	end

	it "can calculate total expenses over a date range" do
		@account.total_expenses( @beginning, @ending).should == 450.0
	end
end
