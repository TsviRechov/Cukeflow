# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pnl        :string(255)
#  date       :datetime
#  note       :string(255)
#  amount     :decimal(, )
#

class Item < ActiveRecord::Base
  belongs_to :account
  attr_accessible :pnl, :date, :account, :account_id, :note,
		:amount

	def self.pnl_types
		[ "income", "expense"]
	end

	def formatted_date
		date.strftime( "%B %-d, %Y" )
	end
end
