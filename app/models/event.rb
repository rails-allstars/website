class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  belongs_to :organizer, :class_name => "User"

  scope :previous, lambda { where('start_time <= ?', Time.now.at_midnight).order('start_time DESC') }
  scope :upcoming, lambda { where('start_time > ?', Time.now.at_midnight).order('start_time ASC') }

end
