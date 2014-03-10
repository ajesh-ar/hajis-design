class CreditDebitController < ApplicationController

	def index
		@customers = Customer.all
	end

	def new
		@customers = Customer.all
	end

	def create
		customer_current_balance = CustomerAccount.where(customer_id: params[:customer][:id]).all.map(&:balance_amount).sum
		customer = Customer.find(params[:customer][:id])
		customer.old_balance = customer.old_balance - params[:customer][:amount].to_f
		if customer.save
			flash[:notice] = 'Added Successfully'
			redirect_to credit_debit_index_path
		else
			flash[:notice] = 'Some Error'
			redirect_to new_credit_debit_path
		end
	end
end