class AttendancesController < ApplicationController

  def create
    event = Event.find params[:event_id]
    attendance = event.rsvp(current_user, params[:status])
    respond_to do |format|
      format.json { render :json => { :success => attendance } }
      format.html { redirect_to :back }
    end
  end

end
