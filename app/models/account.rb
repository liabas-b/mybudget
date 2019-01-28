# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  sold        :float
#  sold_date   :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Account < ActiveRecord::Base
  validates :name, presence: true

  has_many :operations
  has_many :incomes, -> { where('amount >= 0') }, class_name: 'Operation'
  has_many :outcomes, -> { where('amount < 0') }, class_name: 'Operation'
  has_many :simulated_account_operations

  def fold_simulated_operations_until(to_date)
    simulated_account_operations.delete_all
    # start_date = Date.parse(Figaro.env.application_start_date)
    (sold_date.to_date..to_date.to_date).each do |day|
      puts "Processing day: #{day}"
      operations.each do |operation|
        if operation.is_on_day?(day)
          simulated_account_operations.create!(operation.to_simulated_account_operation(day))
        end
      end
    end
    simulated_account_operations
  end

  def sold_at(date)
    raise 'Given date was lower than or equal to last sold date' if date <= sold_date
    fold_simulated_operations_until(date)
    sold + simulated_account_operations.map(&:amount).inject(:+)
  end

  def incomes_amount(frequency = nil)
    sum_operations('incomes', frequency)
  end

  def outcomes_amount(frequency = nil)
    sum_operations('outcomes', frequency)
  end

  def sum_operations(type = nil, frequency = nil)
    filtered = (type == 'incomes' ? incomes : outcomes)
    filtered = filtered.where(frequency: frequency) if frequency
    filtered.map(&:amount).inject(:+)
  end
end
