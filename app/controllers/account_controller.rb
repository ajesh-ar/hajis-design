class AccountController < ApplicationController

	def index
		@customer_amounts = CustomerAccount.includes(:customer)
	end

	def user_details
		render json: User.first
	end

	def calculate
		customer_account = CustomerAccount.new()
		customer_account.customer_id = params[:sales][:customer_id]
		customer_account.vehicle_boxes = params[:sales][:noOfBoxes]
		customer_account.date = params[:sales][:calender_date]
		customer_account.rate = params[:sales][:averageRate].to_f
		customer_account.shed_kg = params[:sales][:shedKg].to_f
		customer_account.vehicle_kg = params[:sales][:vehicleKg].to_f
		customer_account.feed_amount = params[:sales][:feedAmount].to_f
		customer_account.amount = params[:sales][:paidAmount].to_f
		customer_account.balance_amount = get_balance_amount params
		if customer_account.save
			update_balance_amount balance_amount
			render :json => {:message => 'Success', :status => 200}
		else
			render :json => {:message => 'Error', :status => 400}
		end
	end

	def get_balance_amount params
		(params[:sales][:averageRate].to_f*(params[:sales][:vehicleKg].to_f + params[:sales][:shedKg].to_f) + params[:sales][:feedAmount].to_f - params[:sales][:paidAmount].to_f)
	end

	def update_balance_amount balance_amount
		old_balance = balance_amount.customer.old_balance
		new_balance = balance_amount.balance_amount
		total_balance = old_balance + new_balance
		balance_amount.customer.update_attribute('old_balance', total_balance)
	end

	def edit
		customer_account = CustomerAccount.find(params[:id]) if params[:id].present?
		if customer_account.present?
			render :json => {:resp => customer_account, :status => 200}
		else
			render :json => {:resp => nil, :status => 400}
		end
	end

	def update
		
	end
end