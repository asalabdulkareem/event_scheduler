class LectureController < ApplicationController
  def new
    @lecture = Event.new event_type: 'lecture'
  end
  
  # review lecture
  def review
    @lecture = Event.new lecture_params
    
    # convert days and times into available_time objects
    # available times are given as params[:day] = ["monday", ...], params[:from] = [28800, ...], params[:to] = [28800, ...]
    params[:day].each_with_index do |day, i|
      available_time = AvailableTime.build_on_day(day: day, from: params[:from][i].to_i, to: params[:to][i].to_i)
      @lecture.available_times << available_time
    end
    
    # generate timetable for review
    @timetable = AvailableTime.lecture_timetable(@lecture.available_times)
    
    # if validations do not pass, show errors!
    if @lecture.invalid?
      render :new
    end
  end
  
  private
  
  # allowed POST parameters for lectures
  def lecture_params
    params.require(:event)
      .permit(:lecture_title, :description, :email, :num_times, :duration)
      .merge(event_type: 'lecture')
  end
end
