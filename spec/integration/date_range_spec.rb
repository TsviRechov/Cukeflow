require 'spec_helper'

describe "account show page: filter items by date range" do
  before :all do
		@account = create( :account)
		@t0, @t1 = "November 9, 2012", "November 11, 2012"
		@beginning = Date.parse( @t0).to_time
		@ending = Date.parse( @t1).to_time
	end

	after :all do
		Account.destroy_all; Item.destroy_all
	end

	before :each do
		visit account_path( @account)
		@rows = page.find( "table#account_items").all( "tr")[1..4]
	end

	it "the default is that the user views all account items" do
		@rows.map { |tr| tr.all( "td")[0..3].map { |td| td.text.strip } }.should ==
			@account.items.map { |i| i.to_a }
	end

	it "the user can select the beginning of the range" do
		[ "year", "month", "day" ].each { |t|
			page.has_selector?( "select#begin_" + t).should == true
		}
	end

	it "the user can select the ending of the range" do
		[ "year", "month", "day" ].each { |t|
			page.has_selector?( "select#end_" + t).should == true
		}
	end

	it "the user can request date range filtering"

	it "the user can clear the date range and view all account items" do
		page.find_link( 'All').click
		current_path.should == account_path( @account)
		@rows.map { |tr| tr.all( "td")[0..3].map { |td| td.text.strip } }.should ==
			@account.items.map { |i| i.to_a }
	end
end
