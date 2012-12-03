FactoryGirl.define do
  factory :account do
    name 'Tsvi Bar-David'

		items {
			[ 
				create( :income_item,
					date:  "October 15, 2012",
					note: "jquery jasmine",
					amount:  3000.0
				),
				create( :expense_item,
					date: "October 11, 2012", 
					note:  "faster laptop", 
					amount:  1100.0 
				),
				create( :income_item),
				create( :expense_item)
			]
		}
  end

	factory :item do
		factory :income_item do
			date	"November 10, 2012"
			note	"ruby on rails"
			pnl		"income"
			amount 6000.0
		end

		factory :expense_item do
			date	"November 10, 2012"
			note	"air tix to nj"
			pnl		"expense"
			amount 450.0
		end
	end
end
