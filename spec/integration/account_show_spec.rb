require 'spec_helper'

describe "account show page" do
  before :all do
		@items_table = [
			[ "October 15, 2012"  , "jqery jasmine" , "income" , 3000.0 ],
			[ "October 11, 2012"  , "faster laptop" , "expense" , 1100.0 ],
			[ "November 10, 2012" , "ruby on rails" , "income"  , 6000.0 ],
			[ "November 10, 2012" , "air tix to nj" , "expense" , 450.0  ]
		]

		@account = Account.create( :name => "Tsvi Bar-David")
		@items_table.each { |r|
			@account.items.create(
				:date =>	r[0],
				:note =>	r[1],
				:pnl =>		r[2],
				:amount => r[3]
			)
		}
	end

	after :all do
		Account.destroy_all; Item.destroy_all
	end

	before :each do
		visit account_path( @account)
	end

	it "for each item displays in separate columns:  date, note, income, expense" do
		table_headers = page.all( "table#account_items th")
		table_headers.map { |hdr| hdr.text.strip }.should ==
			[ "date", "note", "income", "expense", "operations" ]
	end

	it "displays income and expense items in separate columns " do
		rows = @items_table.map { |r|
			r[0..1] + [ 
				(r[2] == "income") ? r[3].to_s : "-",
				(r[2] == "expense") ? r[3].to_s : "-"
			]
		}

		table_rows = page.all( "table#account_items tr")
		table_rows.length.should == @account.items.count + 2

		table_rows[1..4].map { |r|
			r.all( "td" ).map { |td| td.text.strip }
		}.should == rows
	end

	it "displays income items in green" do
		page.has_selector?("td#income[@style='color:green']").should == true
	end

	it "displays total income in green" do
		page.has_selector?("td#total_income[@style='color:green']").should == true
	end

	it "displays expense items in red" do
		page.has_selector?("td#expense[@style='color:red']").should == true
	end

	it "displays total income underneath the column of income items" do
		page.has_selector?("table#account_items td#total_income").should == true
	end

	it "displays total expenses underneath the column of expense items" do
		page.has_selector?("table#account_items td#total_expenses").should == true
	end

	it "displays total expenses in red" do
		page.has_selector?("td#total_expenses[@style='color:red']").should == true
	end
end
