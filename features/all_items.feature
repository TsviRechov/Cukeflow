Feature: user views all items in cashflow account
	As a user
	I want to be able to see the items in my cashflow account
	in order to know when I am running out of money

	# refine by putting in the scenarios between the scenarios
	Scenario:  user can launch cashflow application
		When I launch the cashflow application
		Then I see "Welcome to the Cashflow Application"

	Scenario:  user creates a cashflow account
		Given I do not have a cashflow account
		When I create my new cashflow account with "name" "Tsvi Bar-David"
		Then I see a cashflow account with the "name" "Tsvi Bar-David" 

	Scenario:  user adds an income item to their cashflow account
		Given I have a cashflow account empty of items
		When I add an income item to my account
		Then I see my account with its one item of type income

	Scenario:  user adds an expense item to their cashflow account
		Given I have a cashflow account empty of items
		When I add an expense item to my account
		Then I see my account with its one item of type expense

	Scenario:  user views all the items of their cashflow account
		Given my cashflow account has the following items in it:
				| date							| note					| pnl			| amount 	|
				| November 10, 2012	| ruby on rails	| income	| 6000.0 	|
				| November 10, 2012	| air tix to nj | expense	| 450.0  	|
		When I go to view my cashflow account
		Then I see all of the items in my cashflow account
