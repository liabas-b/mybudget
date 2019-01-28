class CreateSimulatedAccountOperations < ActiveRecord::Migration
  def change
    create_table :simulated_account_operations do |t|
      t.float :amount
      t.datetime :date
      t.integer :operation_id
      t.integer :account_id

      t.timestamps
    end
  end
end
