class HomeController < ApplicationController
	before_filter :get_rails_data, only: [:index]

	def index
		@customers = Customer.order('old_balance DESC')
	end

	private

		def get_rails_data
			@rails_sales_data = CustomerAccount.group_by_date.map {
														|k, v|
															{
																date: k,
																amount: v.map(&:amount).sum,
																balance: v.map(&:balance_amount).sum
															}
													}
			@rails_farm_data = Farm.all.map { |m| { label: m.name, value: m.distance_to_display } }
		end
end