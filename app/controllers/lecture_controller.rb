class LectureController < ApplicationController
  def new
    @lecture = Event.new event_type: 'lecture'
  end

  def review
  end

  def create
    @lecture = Event.create lecture_params
    redirect_to controller: :event, action: :success, id: @lecture
  end
  
  private
  
  def lecture_params
    params.require(:lecture)
      .permit(:lecture_title, :description, :email, :num_times, :duration)
      .merge(event_type: 'lecture')
  end
end
