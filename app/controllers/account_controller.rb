class AccountController < ApplicationController

	def index
		@customer_amounts = CustomerAccount.includes(:customer)

		# respond_to do |format|
  #     format.html
  #     format.json { render json: CustomerAccountDatatable.new(view_context) }
  #   end
	end

	def manage
		@customer_versions = Customer.first.versions
	end

	def user_details
		render json: User.first
	end

	def calculate
		customer_account = CustomerAccount.new()
		customer_account = updateSalesDB(params, customer_account)
		if customer_account.save
			update_balance_amount customer_account
			render :json => {:message => 'Success', :status => 200}
		else
			render :json => {:message => 'Error', :status => 400}
		end
	end

	def get_balance_amount params
		(params[:sales][:averageRate].to_f*(params[:sales][:vehicleKg].to_f + params[:sales][:shedKg].to_f) + params[:sales][:feedAmount].to_f - params[:sales][:paidAmount].to_f)
	end

	def edit
		resp = CustomerAccount.find(params[:id]) if params[:id].present?
		out_put_hash = {
			rate: resp.rate,
	    vehicle_kg: resp.vehicle_kg,
	    feed_amount: resp.feed_amount,
	    amount: resp.amount,
	    shed_kg: resp.shed_kg,
	    vehicle_boxes: resp.vehicle_boxes,
	    date: (resp.date ? resp.date.strftime('%d/%m/%Y') : nil), # 13/01/2015
	    customer_id: resp.customer_id
		}
		if out_put_hash.present?
			render :json => {:resp => out_put_hash, :status => 200}
		else
			render :json => {:resp => nil, :status => 400}
		end
	end

	def update
		customer_account = CustomerAccount.find(params[:sales][:customer_account_id])
		customer_account_old_balance = customer_account.balance_amount
		customer_account = updateSalesDB(params, customer_account)
		if customer_account.save
			update_balance_amount(customer_account)
			render :json => {:message => 'Success', :status => 200}
		else
			render :json => {:message => 'Error', :status => 400}
		end
	end

	def updateSalesDB params, customer_account
		customer_account.customer_id = params[:sales][:customer_id]
		customer_account.vehicle_boxes = params[:sales][:noOfBoxes]
		customer_account.date = params[:sales][:calender_date]
		customer_account.rate = params[:sales][:averageRate].to_f
		customer_account.shed_kg = params[:sales][:shedKg].to_f
		customer_account.vehicle_kg = params[:sales][:vehicleKg].to_f
		customer_account.feed_amount = params[:sales][:feedAmount].to_f
		customer_account.amount = params[:sales][:paidAmount].to_f
		customer_account.balance_amount = get_balance_amount params
		customer_account
	end

	def update_balance_amount(customer_account)
		customer_current_balance = CustomerAccount.where(customer_id: customer_account.customer_id).all.map(&:balance_amount).sum
		customer_account.customer.update_attribute('old_balance', customer_current_balance)
	end
end