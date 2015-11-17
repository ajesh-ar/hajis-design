class Customer < ActiveRecord::Base
  attr_accessible :address, :email, :old, :phone, :name, :current_balance

  has_many :customer_accounts, :dependent => :destroy

  column_names.map( &:to_sym ).each {
  	|c|
  		if c.eql? :email
  			validates c, uniqueness: true
  			validates_format_of c, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  		end
  		validates_presence_of c if [:address, :phone, :name].include?(c)
  }

  has_paper_trail
end
