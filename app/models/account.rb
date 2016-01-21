class Account < ActiveRecord::Base
  include Mongoid::Document

  has_many :operations
  has_many :simulated_account_operations

  def fold_simulated_operations_until(to_date)
    simulated_account_operations.delete_all
    # start_date = Date.parse(Figaro.env.application_start_date)
    (sold_date..to_date).each do |day|
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
    simulated_account_operations.map(&:amount).inject{|sum,x| sum + x }
  end
end
