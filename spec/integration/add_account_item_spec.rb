require 'spec_helper'

# web gui specification - dried out of the cucumber
describe "add item to account" do
	before :all do
		@owner = "Tsvi Bar-David"
		@account = Account.create( :name => @owner)
	end

	after :all do
		Account.destroy_all
		Item.destroy_all
	end

	it "can navigate to an account show page" do
		@account.should_not be_nil
		visit( account_path( @account))
	end

	it "the account show page displays the name of the account owner" do
		visit( account_path( @account))
		page.has_content?( @owner)
	end

	describe "the account owner can add a new item to her/his account" do
		before :each do
			visit( account_path( @account))
		end

		it "the account owner can set the date for a new item" do
			page.has_field?( 'Date').should be_true 
			page.select '2013', :from => 'item_date_1i'
			page.select 'November', :from => 'item_date_2i'
			page.select '13', :from => 'item_date_3i'

			# now that we are totaling income and expenses, need to set amount to something
			# or we should default it in the database schema
			page.fill_in( 'Amount', :with => 0.0)
			
			# OK, click the submit button
			page.has_button?( 'Create Item').should be_true
			@account.items.count.should == 0
			page.find_button( 'Create Item').click
			@account.items.count.should == 1
			item  = @account.items.first
			item.date.year.should == 2013
			item.date.month.should == 11
			item.date.day.should == 13
		end

		it "the account owner can set the note for a new item" do
			page.has_field?( 'Note').should be_true 
			page.fill_in( 'Note', :with => "ruby on rails workshop")
			page.fill_in( 'Amount', :with => 0.0)
			page.find_button( 'Create Item').click
			@account.items.where( :note => "ruby on rails workshop").count.should == 1
		end

		it "the account owner can set the pnl type for a new item to income" do
			page.has_select?( 'Pnl').should be_true 
			Item.pnl_types.sort.should == [ "expense", "income" ] # belongs in item_spec.rb

			Item.pnl_types.each { |pnl|
				page.fill_in( 'Amount', :with => 0.0)
				page.select( pnl, :from => "Pnl")
				page.find_button( 'Create Item').click
				@account.items.where( :pnl => pnl).count.should == 1
			}
		end

		it "the account owner can set the amount for a new item" do
			page.has_field?( 'Amount').should be_true 
			page.fill_in( 'Amount', :with => 6000.00)
			page.find_button( 'Create Item').click
			@account.items.where( :amount => 6000.00).count.should == 1
		end

		it "the account owner can add an item to her/his account and view it" do
			# fully fill in an item in the form
			page.select '2013', :from => 'item_date_1i'
			page.select 'November', :from => 'item_date_2i'
			page.select '13', :from => 'item_date_3i'
			page.fill_in( 'Note', :with => "ruby on rails workshop")
			page.select( "income", :from => "Pnl")
			page.fill_in( 'Amount', :with => 6000.00)
			page.find_button( 'Create Item').click
			@account.items.count.should == 1
			current_path.should == account_path( @account)
			page.all( "table#account_items tr").length.should == @account.items.count + 2
			r = page.all( "table#account_items tr")[1].all( "td")
			r.length.should == 4
			r.map { |e| e.text.strip }.should ==
				["November 13, 2013", "ruby on rails workshop", "6000.0", "-" ]
		end
	end
end
