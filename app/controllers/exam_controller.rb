class ExamController < ApplicationController
  def new
    @exam = Event.new event_type: 'exam'
  end

  # review exam
  def review
    @exam = Event.new exam_params
    
    # convert days and times into available_time objects
    # available times are given as params[:date] = ["2016-12-28", ...], params[:from] = [28800, ...], params[:to] = [28800, ...]
    params[:date].each_with_index do |date, i|
      available_time = AvailableTime.build_on_date(date: date, from: params[:from][i].to_i, to: params[:to][i].to_i)
      @exam.available_times << available_time
    end
    
    # generate timetable for review
    @timetable = AvailableTime.exam_timetable(@exam.available_times)
    
    # if validations do not pass, show errors!
    if @exam.invalid?
      render :new
    end
  end
  
  private
  
  # allowed POST parameters for exams
  def exam_params
    params.require(:event)
      .permit(:lecture_title, :description, :email, :duration)
      .merge(num_times: 0)
      .merge(event_type: 'exam')
  end
end
