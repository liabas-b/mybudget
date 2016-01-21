# == Schema Information
#
# Table name: simulated_account_operations
#
#  id         :integer          not null, primary key
#  amount     :float
#  date       :datetime
#  income_id  :integer
#  outcome_id :integer
#  account_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class SimulatedAccountOperation < ActiveRecord::Base
  belongs_to :account
  belongs_to :operation

  def name
    "Simulated #{operation.name}"
  end
end
