class EventController < ApplicationController
  def new
  end
  
  def create
    @event = Event.new event_params
    # available times are submitted as UNIX timestamps
    params[:from].zip(params[:to]).each do |from, to|
      @event.available_times << AvailableTime.new(from: Time.at(from.to_i), to: Time.at(to.to_i))
    end
    @event.save
    redirect_to action: :success, id: @event
  end

  def success
    @event = Event.find params[:id]
  end
  
  private
  
  def event_params
    params.require(:event)
      .permit(:event_type, :lecture_title, :description, :email, :num_times, :duration)
  end
end
