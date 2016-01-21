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
  belongs_to :account

  validates :name, presence: true
  validates :date, presence: true
  validates :amount, presence: true

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
