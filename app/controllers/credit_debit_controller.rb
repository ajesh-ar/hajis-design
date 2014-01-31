class CreditDebitController < ApplicationController

	def index
		@customers = Customer.all
	end
end