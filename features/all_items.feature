Feature: user views all items in cashflow accountf
	As a user
	I want to be able to see the items in my cashflow account
	in order to know when I am running out of money

	Scenario:  user creates a cashflow account
		Given that I do not have a cashflow account
		When I go to the homepage
			And I follow "New cashflow account"
			And I fill in "name" with "Tsvi Bar-David"
			And I press "Create new cashflow account"
		Then I see a cashflow account with the "name" "Tsvi Bar-David" on the showpage for a cashflow account

	Scenario:  user adds an income item to their cashflow account

	Scenario:  user adds an expense item to their cashflow account

	Scenario:  user views all the items of their cashflow account
