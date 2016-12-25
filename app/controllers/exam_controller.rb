class ExamController < ApplicationController
  def new
    @exam = Event.new event_type: 'exam'
  end

  def review
  end

  def create
    @exam = Event.create exam_params
    redirect_to controller: :event, action: :success, id: @exam
  end
  
  private
  
  def exam_params
    params.require(:exam)
      .permit(:lecture_title, :description, :email, :num_times, :duration)
      .merge(event_type: 'exam')
  end
end
