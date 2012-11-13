# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :name
	has_many :items

	def total_income
		self.items.where( :pnl => "income").reduce( 0.0) { |s,i|
			s + i.amount
		}
	end

	def total_expenses
		self.items.where( :pnl => "expense" ).reduce( 0.0) { |s,i|
			s + i.amount
		}
	end
end
