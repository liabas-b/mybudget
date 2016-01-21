class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :name
      t.string :description
      t.float :amount
      t.datetime :date
      t.datetime :date_from
      t.datetime :date_to
      t.boolean :is_recurrent, default: false
      t.string :frequency
      t.integer :account_id

      t.timestamps
    end
  end
end
