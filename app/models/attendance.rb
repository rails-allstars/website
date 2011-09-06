class Attendance < ActiveRecord::Base
  RSVP = %w(no maybe yes)

  belongs_to :user
  belongs_to :event

  validates_inclusion_of :status, :in => RSVP
end
