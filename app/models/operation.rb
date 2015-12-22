class Operation
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :amount, type: Float
  field :date, type: DateTime
  field :date_from, type: DateTime
  field :date_to, type: DateTime
  field :is_recurrent, type: Boolean, default: false
  field :frequency, type: String

  validates :name, presence: true
  validates :date, presence: true
  validates :amount, presence: true

  def to_simulated_account_operation(operation_date = nil)
    if _type == 'Income'
      { amount: amount, date: operation_date || date, income_id: id }
    else
      { amount: amount, date: operation_date || date, outcome_id: id }
    end
  end

  def is_income?
    self.class.to_s == 'Income'
  end

  def is_outcome?
    self.class.to_s == 'Outcome'
  end

  def is_on_day?(day)
    day.to_date == self.date.to_date || matches_recurring_date?(day)
  end

  def matches_recurring_date?(day)
    return false unless is_recurrent?
    return false unless (date_from && date_from <= day) && (date_to && date_to >= day)
    case frequency
    when 'daily'
      true
    when 'weekly'
      day.wday == date.wday
    when 'monthly'
      # if day.days_in_month > date.mday
      day.mday == date.mday
    when 'yearly'
      day.yday == date.yday
    else
      false
    end
  end

  def processed_amount
    is_income? ? amount : -amount
  end

end
