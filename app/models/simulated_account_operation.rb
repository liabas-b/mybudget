class SimulatedAccountOperation
  include Mongoid::Document

  embedded_in :account

  field :amount, type: Float
  field :date, type: DateTime
  field :income_id, type: String
  field :outcome_id, type: String

  def name
    is_income? ? income.name : (is_outcome? ? outcome.name : '-')
  end

  def income
    account.incomes.find(income_id) if income_id
  end

  def outcome
    account.outcomes.find(outcome_id) if outcome_id
  end

  def is_income?
    income.present?
  end

  def is_outcome?
    outcome.present?
  end

end
