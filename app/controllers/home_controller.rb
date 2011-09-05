class HomeController < ApplicationController
  def index
    @next_event = Event.upcoming.first
    @last_event = Event.previous.first
    @upcoming = Event.upcoming
    @previous = Event.previous
  end
end
