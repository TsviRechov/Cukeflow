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

require 'spec_helper'

describe Item do
  pending "add some examples to (or delete) #{__FILE__}"
end
