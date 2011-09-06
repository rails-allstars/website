class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  belongs_to :organizer, :class_name => "User"

  scope :previous, lambda { where('start_time <= ?', Time.now.at_midnight).order('start_time DESC') }
  scope :upcoming, lambda { where('start_time > ?', Time.now.at_midnight).order('start_time ASC') }

  def rsvp(user, status)
    a = attendances.find_or_create_by_user_id user, { :status => 'maybe' }
    a.update_attributes :status => status
  end

  def rsvp_of(user)
    attendances.find_by_user_id(user.id).try(:status).to_s.inquiry
  end

end
