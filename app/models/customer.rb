class Customer < ActiveRecord::Base
  attr_accessible :address, :email, :old, :phone
  has_many :customer_accounts, :dependent => :destroy
  validates :email, uniqueness: true
  has_paper_trail
end
