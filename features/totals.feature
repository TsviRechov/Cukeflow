Feature:
	As a user
	I want to be able to see
	my total income and total expenses
	for all the items in my cashflow account
	in order to feel pride in my earning capacity
	and in order to have a sober, accurate assessment
	of my expenses

	Scenario:  user views all the items of their cashflow account
		and total income and expenses
		Given my cashflow account looks like:
				| date							| note					| pnl			| amount 	|
				| October 15, 2012	| jqery jasmine	| income	| 3000.0 	|
				| October 11, 2012	| faster laptop | expense	| 1100.0 	|
				| November 10, 2012	| ruby on rails	| income	| 6000.0 	|
				| November 10, 2012	| air tix to nj | expense	| 450.0  	|
		When I view my cashflow account
		Then I see the "4" items in the "Tsvi Bar-David" cashflow account
			And I see my total income and total expenses:
				| total income	| total expenses	|
				|	9000.0				| 1550.0					|
