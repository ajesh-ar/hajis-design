class CustomerAccount < ActiveRecord::Base
  attr_accessible :amount, :balance, :customer_id, :date, :feed_amount, :rate, :shed_kg, :vehicle_boxes, :vehicle_kg
  belongs_to :customer
end
