class SimulatedAccountOperation < ActiveRecord::Base
  belongs_to :account
  belongs_to :operation

  def name
    "Simulated #{operation.name}"
  end
end
