When /^I filter the view of my cashflow account items through the range:$/ do |table|
	# business logic
	# @account2 is cucumber accessible from some other step
	@account2.items.count.should == 4

	@beginning = Date.parse( table.raw[1][0]).to_time
	@ending = Date.parse( table.raw[1][1]).to_time
	
	# view logic
end

Then /^I see "(.*?)" items in the filtered account view:$/ do |item_count, table|
	# business logic
  @filtered_items = @account2.items_date_range( @beginning, @ending)
  @filtered_items.length.should == item_count.to_i
	@filtered_items.map { |i|
		[ i.formatted_date, i.note, i.pnl, i.amount.to_s( "F") ]
	}.should == table.raw

	# view logic
end

Then /^I see the following total income and total expenses:$/ do |table|
	# business logic
	total_income = table.raw[1][0]
	total_expenses = table.raw[1][1]

	@account2.total_income( @beginning, @ending).should == total_income.to_f
	@account2.total_expenses( @beginning, @ending).should == total_expenses.to_f

	# view logic
end
