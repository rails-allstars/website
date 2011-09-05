class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  belongs_to :organizer, :class_name => "User"
end
