# == Schema Information
#
# Table name: operations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :string(255)
#  amount       :float
#  date         :datetime
#  date_from    :datetime
#  date_to      :datetime
#  is_recurrent :boolean          default(FALSE)
#  frequency    :string(255)
#  account_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Operation < ActiveRecord::Base
  FREQUENCIES = %w[punctual daily weekly monthly yearly]

  belongs_to :account

  validates :name, presence: true
  validates :date, presence: true
  validates :amount, presence: true

  before_save :pad_date_to_month

  def pad_date_to_month
    self.date = date.change(day: 28) if date.day > 28
  end

  def to_simulated_account_operation(operation_date = nil)
    { amount: amount, date: operation_date || date, operation_id: id }
  end

  def is_income?
    amount >= 0
  end

  def is_outcome?
    amount < 0
  end

  def is_on_day?(day)
    day.to_date == self.date.to_date || matches_recurring_date?(day)
  end

  def matches_recurring_date?(day)
    return false if date_from && date_to && !(date_from..date_to).include?(day)
    case frequency
    when 'daily'
      true
    when 'weekly'
      day.wday == date.wday
    when 'monthly'
      day.mday == date.mday
    when 'yearly'
      day.yday == date.yday
    else
      false
    end
  end
end
