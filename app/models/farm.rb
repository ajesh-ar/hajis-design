class Farm < ActiveRecord::Base
  attr_accessible :country, :latitude, :longitude, :name, :phone, :place, :state, :street, :distance

  validates_presence_of :street, :state, :name, :place
  validates :phone,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }

  after_validation :geocode, if: lambda { |l| l.address.present? }
  geocoded_by :address

  before_save :assign_distance

  default_scope { where("phone != #{HOME_PHONE}") }

  # Getter method for concat address components.
  def address
    [street, place, state, country].join(', ')
  end

  def distance_to_display
    distance.round(2)
  end

  def display_name
    "#{name}(#{place})"
  end

  private
    def assign_distance
      home_farm = self.class.unscoped.where(phone: HOME_PHONE).first
      return if home_farm.nil?

      self.distance = home_farm.distance_to([self.latitude, self.longitude])
    end
end
