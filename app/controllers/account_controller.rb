class AccountController < ApplicationController

	def index
		@users = User.all
	end

	def user_details
		render json: User.first
	end
end