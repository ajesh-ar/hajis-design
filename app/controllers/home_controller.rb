class HomeController < ApplicationController

	def index
		@customers = Customer.order('old_balance DESC')
	end
end