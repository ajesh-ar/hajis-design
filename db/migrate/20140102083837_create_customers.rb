class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :address
      t.integer :phone
      t.string :email
      t.float :old_balance

      t.timestamps
    end
  end
end
