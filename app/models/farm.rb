class Farm < ActiveRecord::Base
  attr_accessible :country, :latitude, :longitude, :name, :phone, :place, :state, :street

  validates_presence_of :street, :state, :name
  validates :phone,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }
  
  after_validation :geocode, if: lambda { |l| l.address.present? }
  geocoded_by :address

  # Getter method for concat address components.
  def address
    [street, place, state, country].join(', ')
  end

end
