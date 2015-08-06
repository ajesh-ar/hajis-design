class CustomerAccount < ActiveRecord::Base
  attr_accessible :amount, :balance, :customer_id, :date, :feed_amount, :rate, :shed_kg, :vehicle_boxes, :vehicle_kg
  belongs_to :customer

  def self.group_by_date; where('date >= ?', (Date.today - 1.month)).group_by { |e| e.date.to_date }; end;
end
