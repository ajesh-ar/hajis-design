class AddCurrentBalanceToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :current_balance, :float
  end
end
