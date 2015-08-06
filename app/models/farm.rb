class Farm < ActiveRecord::Base
  attr_accessible :country, :latitude, :longitude, :name, :phone, :place, :state, :street, :distance

  validates_presence_of :street, :state, :name
  validates :phone,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }
  
  after_validation :geocode, if: lambda { |l| l.address.present? }
  geocoded_by :address

  before_save :assign_distance

  # Getter method for concat address components.
  def address
    [street, place, state, country].join(', ')
  end

  def distance_to_display
    distance.round(2)
  end

  private
    def assign_distance
      self.distance = self.class.where(place: HOME_TOWN).first
                     .distance_to([self.latitude, self.longitude])
    end

end
