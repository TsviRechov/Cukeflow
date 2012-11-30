Given /^my cashflow account looks like:$/ do |table|
  # table is a Cucumber::Ast::Table
	@items_table = table.raw
  @account2 = Account.create( :name => "Tsvi Bar-David")
	@items_table[1..4].each { |r|
		@account2.items.create(
			:date =>	r[0],
			:note =>	r[1],
			:pnl =>		r[2],
			:amount => r[3]
		)
	}
end

When /^I view my cashflow account$/ do
  visit account_path( @account2)
end

Then /^I see my total income and total expenses:$/ do |table|
  # table is a Cucumber::Ast::Table
  t = table.raw
	total_income, total_expenses  = t[1][0], t[1][1]
	total_income.should == "9000.0"
	total_expenses.should == "1550.0"

	# tests business logic, should be in rspec 
	@account2.items.count.should == 4
	@account2.total_income.should == total_income.to_f
	@account2.total_expenses.should == total_expenses.to_f

	# tests presentation logic
	page.has_selector?( 'td#total_income').should == true
	page.has_selector?( 'td#total_expenses').should == true
	page.find('td#total_income').text.strip.should == total_income
	page.find('td#total_expenses').text.strip.should == total_expenses
end

Then /^I see the "(.*?)" items in the "(.*?)" cashflow account$/ do |item_count, arg2|
	ic = item_count.to_i
	page.all( "table#account_items tr").length.should == ic + 2
	page.all( "table#account_items tr")[1..ic].map { |e| 
		e.all( "td")[0..3].map { |td| td.text.strip } 
	}.should == @account2.items.map { |i| i.to_a }
end

