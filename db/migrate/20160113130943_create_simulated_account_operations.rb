class CreateSimulatedAccountOperations < ActiveRecord::Migration
  def change
    create_table :simulated_account_operations do |t|
      t.float :amount
      t.datetime :date
      t.integer :income_id
      t.integer :outcome_id
      t.integer :account_id

      t.timestamps
    end
  end
end
