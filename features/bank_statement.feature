Feature:
	As a user of cashflow
	I want to be able to electronically download
	my monthly checking account statement
	in order to make it easy
	to keep my cashflow picture complete and up-to-date

	Scenario:  user downloads a month's-worth of checking account statement
		Given I have a cashflow account
		When I download a month's worth of checking account statement
		Then the downloaded information is integrated into my cashflow account
			And I see the newly downloaded statement integrated integrated into my cashflow account
