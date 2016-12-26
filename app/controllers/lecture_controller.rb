class LectureController < ApplicationController
  def new
    @lecture = Event.new event_type: 'lecture'
  end

  def review
    @lecture = Event.new lecture_params
    
    # convert days and times into available_time objects
    params[:day].each_with_index do |day, i|
      available_time = AvailableTime.build_on_day(day: day, from: params[:from][i].to_i, to: params[:to][i].to_i)
      @lecture.available_times << available_time
    end
    
    @timetable = AvailableTime.lecture_timetable(@lecture.available_times)
  end
  
  private
  
  def lecture_params
    params.require(:event)
      .permit(:lecture_title, :description, :email, :num_times, :duration)
      .merge(event_type: 'lecture')
  end
end
