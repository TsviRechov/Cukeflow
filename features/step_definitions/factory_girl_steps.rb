World( FactoryGirl::Syntax::Methods) # probably a dryer place to put this

Given /^I want to dry out my cucumber scripts$/ do
  true
end

When /^I create an account using FactoryGirl$/ do
  @account = create( :account)
end

Then /^I see an account with a bunch of income and expense items$/ do
  @account.name.should == 'Tsvi Bar-David'
  @account.items.length.should == 4
  @account.items.map { |i| i.note }.should == [
		"jquery jasmine", "faster laptop", "ruby on rails", "air tix to nj"
	]
end
