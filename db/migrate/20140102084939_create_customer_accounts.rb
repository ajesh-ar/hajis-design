class CreateCustomerAccounts < ActiveRecord::Migration
  def change
    create_table :customer_accounts do |t|
      t.integer :customer_id
      t.float :shed_kg
      t.float :vehicle_kg
      t.float :rate
      t.float :feed_amount
      t.float :amount
      t.float :balance_amount
      t.datetime :date
      t.integer :vehicle_boxes

      t.timestamps
    end
  end
end
