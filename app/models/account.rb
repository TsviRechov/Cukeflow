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

	def items_date_range( beginning, ending)
		items.where( :date => (beginning..ending))
	end

	def total_income( beginning = nil, ending = nil)
		its( beginning, ending).where( :pnl => "income").reduce( 0.0) { |s,i|
				s + i.amount
		}
	end

	def total_expenses( beginning = nil, ending = nil)
		its( beginning, ending).where( :pnl => "expense" ).reduce( 0.0) { |s,i|
			s + i.amount
		}
	end

	def its( beginning, ending)
		(beginning != nil) && (ending != nil) ?
			items.where( :date => (beginning..ending)) :
			self.items
	end
end
