class EventController < ApplicationController
  def new
  end
  
  # CRUD create for events
  def create
    @event = Event.new event_params
    # available times are submitted as UNIX timestamps
    
    # read each available time (sent as a UNIX timestamp string, ie "1482924350")
    params[:from].zip(params[:to]) do |from, to|
      @event.available_times << AvailableTime.new(from: Time.at(from.to_i), to: Time.at(to.to_i))
    end
    # we already validated in LectureController#review or ExamController#review
    @event.save
    redirect_to action: :success, id: @event
  end

  # CRUD read for events
  # find saved event with id params[:id] and display success page
  def success
    @event = Event.find params[:id]
  end
  
  private
  
  # allowed POST parameters
  def event_params
    params.require(:event)
      .permit(:event_type, :lecture_title, :description, :email, :num_times, :duration)
  end
end
