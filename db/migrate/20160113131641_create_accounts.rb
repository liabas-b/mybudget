class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :description
      t.float :sold
      t.datetime :sold_date

      t.timestamps
    end
  end
end
