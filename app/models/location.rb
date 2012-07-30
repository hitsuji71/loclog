class Location
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :user, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :browser, type: String
  field :memo, type: String
end
