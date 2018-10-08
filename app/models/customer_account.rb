class CustomerAccount < ActiveRecord::Base
  attr_accessible :amount, :balance, :customer_id, :date, :feed_amount, :rate, :shed_kg, :vehicle_boxes, :vehicle_kg
  belongs_to :customer

  default_scope { joins(:customer).order("customers.created_at ASC")}

  def self.group_by_date; where('date >= ?', (Date.today - 1.month)).group_by { |e| e.date.to_date }; end;

  def calculated_amount
  	(rate.to_f*(vehicle_kg.to_f + shed_kg.to_f) + feed_amount.to_f)
  end

  def old_balance
  	CustomerAccount.where(customer_id: self.customer_id)
  		.where("date < ?", self.date).map(&:balance_amount).sum
  end

  def total_paid
  	CustomerAccount.where(customer_id: self.customer_id)
  		.where("date < ?", self.date).map(&:amount).sum
  end

  def total
  	CustomerAccount.where(customer_id: self.customer_id)
  		.where("date < ?", self.date).map(&:calculated_amount).sum
  end
end
