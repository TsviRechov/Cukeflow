When /^I launch the cashflow application$/ do
	visit( root_path)
	current_path.should == root_path
end

Then /^I see "(.*?)"$/ do |the_welcome|
	visit( root_path)
	current_path.should == root_path
	page.find( "h1").has_content?( the_welcome).should == true
end

Given /^I do not have a cashflow account$/ do
	Account.all.empty?.should == true
	Account.find_by_name( "Tsvi Bar-David").should == nil
end

When /^I create my new cashflow account with "(.*?)" "(.*?)"$/ do | field_name, name|
	visit( root_path)
  page.find_link( "Create new cashflow account").click
	current_path.should == new_account_path
	page.has_field?( "Name").should == true
	fill_in( "Name", :with => name)
	page.has_field?( "Name", :with => name).should == true
	page.has_button?( "Create Account").should == true
	Account.count.should == 0
	page.find_button( "Create Account").click
	Account.count.should == 1
	current_path.should == account_path( Account.all.first)
end

Then /^I see a cashflow account with the "(.*?)" "(.*?)"$/ do |arg1, name|
	current_path.should == account_path( Account.all.first)
	page.has_content?( name).should == true
end

Given /^I have a cashflow account empty of items$/ do
  @account = Account.create( :name => "Tsvi Bar-David")
	@account.items.empty?.should be_true
end

When /^I add an income item to my account$/ do
  # choice:  test at business object level or at gui level
	# for the app to pass acceptance, must work at web gui
	# could start out by testing at business object level
	# arguably the below is a model test in account_spec.rb or item_spec.rb
	#@account.items.create( :pnl => "income")

	# let's specify and exercise the web gui
	# is this the right file/place to specify?  
	# Where else? spec/integration/account_show_spec.rb
	visit( account_path(@account))
	page.select '2013', :from => 'item_date_1i'
	page.select 'November', :from => 'item_date_2i'
	page.select '13', :from => 'item_date_3i'
	page.fill_in( 'Note', :with => "ruby on rails workshop")
	page.select( "income", :from => "Pnl")
	page.fill_in( 'Amount', :with => 6000.00)
	page.find_button( 'Create Item').click
	@account.items.count.should == 1
end

Then /^I see my account with its one item of type income$/ do
	current_path.should == account_path( @account)
	r = page.all( "table#account_items tr")[1].all( "td")[0..3]
	r.map { |e| e.text.strip }.should ==
		["November 13, 2013", "ruby on rails workshop", "6000.0", "-"]
end

When /^I add an expense item to my account$/ do
	visit( account_path(@account))
	page.select '2013', :from => 'item_date_1i'
	page.select 'November', :from => 'item_date_2i'
	page.select '13', :from => 'item_date_3i'
	page.fill_in( 'Note', :with => "air tickets to New Jersey")
	page.select( "expense", :from => "Pnl")
	page.fill_in( 'Amount', :with => 450.00)
	page.find_button( 'Create Item').click
	@account.items.count.should == 1
end

Then /^I see my account with its one item of type expense$/ do
	current_path.should == account_path( @account)
	r = page.all( "table#account_items tr")[1].all( "td")[0..3]
	r.map { |e| e.text.strip }.should ==
		["November 13, 2013", "air tickets to New Jersey", "-", "450.0"]
end

Given /^my cashflow account has the following items in it:$/ do |table|
  # table is a Cucumber::Ast::Table
	@items_table = table.raw
  @account = Account.create( :name => "Tsvi Bar-David")
	@items_table[1..2].each { |r|
		@account.items.create(
			:date =>	r[0],
			:note =>	r[1],
			:pnl =>		r[2],
			:amount => r[3]
		)
	}
end

When /^I go to view my cashflow account$/ do
	visit( account_path( @account))
end

Then /^I see the "(.*?)" items in my cashflow account$/ do |item_count|
	current_path.should == account_path( @account)
	ic = item_count.to_i
	page.all( "table#account_items tr").length.should == ic + 2
	page.all( "table#account_items tr")[1..ic].map { |e| 
		e.all( "td")[0..3].map { |td| td.text.strip } 
	}.should == @account.items.map { |i| i.to_a }
end
