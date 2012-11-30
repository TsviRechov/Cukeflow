Feature:
	As a user
	I want to be able to filter the view
	of my cashflow account items
	by a date range
	in order to see my cashflow over a specific time period

	Scenario:  user filters view of account items by date range
		and total income and expenses
		Given my cashflow account looks like:
				| date							| note					| pnl			| amount 	|
				| October 15, 2012	| jqery jasmine	| income	| 3000.0 	|
				| October 11, 2012	| faster laptop | expense	| 1100.0 	|
				| November 10, 2012	| ruby on rails	| income	| 6000.0 	|
				| November 10, 2012	| air tix to nj | expense	| 450.0  	|
		When I filter the view of my cashflow account items through the range:
				| beginning					| ending						| 
				| November 9, 2012	| November 11, 2012	| 
		Then I see "2" items in the filtered account view:
				| November 10, 2012	| ruby on rails	| income	| 6000.0 	|
				| November 10, 2012	| air tix to nj | expense	| 450.0  	|
			And I see the following total income and total expenses:
				| total income	| total expenses	|
				|	6000.0				| 450.0						|
