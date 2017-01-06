class EventController < ApplicationController
  def new
  end
  
  # handle special link for participation or viewing results
  def special_link
    link = params[:link]
    
    # participation link?
    event = Event.find_by(link1: link)
    return participate(event) if event
    
    # view results link?
    event = Event.find_by(link2: link)
    return view_results(event) if event
    
    # invalid link
    not_found
  end
  
  # CRUD create for events
  def create
    @event = Event.new event_params
    # available times are submitted as UNIX timestamps
    
    # read each available time (sent as a UNIX timestamp string, ie "1482924350")
    params[:from].zip(params[:to]) do |from, to|
      @event.available_times << AvailableTime.new(from: Time.at(from.to_i), to: Time.at(to.to_i))
    end
    
    # verify recaptcha
    if not verify_recaptcha(params['g-recaptcha-response'])
      # render timetable review if recaptcha invalid
      if @event.event_type == 'lecture'
        @lecture = @event
        @timetable = AvailableTime.lecture_timetable(@event.available_times)
      else
        @exam = @event
        @timetable = AvailableTime.exam_timetable(@event.available_times)
      end
      flash.now[:notice] = "Invalid recaptcha!"
      render @event.event_type + "/review"
    else
      # we already validated in LectureController#review or ExamController#review
      @event.save
      if @event.event_type == 'lecture'
        UserMailer.lecture_created(@event).deliver_now
      else
        UserMailer.exam_created(@event).deliver_now
      end
      redirect_to action: :success, id: @event
    end
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
  
  def verify_recaptcha(response)
    return true if Rails.env.test?
    require 'net/http'
    uri = URI('https://www.google.com/recaptcha/api/siteverify')
    res = Net::HTTP.post_form(uri, 'secret' => Rails.application.secrets.RECAPTCHA_SECRET, 'response' => response)
    return JSON.parse(res.body)['success']
  end
  
  def participate(event)
    return participate_lecture(event) if event.event_type == 'lecture'
    return participate_exam(event)
  end
  
  def participate_lecture(lecture)
    @timetable = AvailableTime.lecture_timetable(lecture.available_times)
    render 'lecture/participate'
  end
  
  def participate_exam(exam)
    render 'exam/participate'
  end
  
  def view_results(event)
    return view_lecture_results(event) if event.event_type == 'lecture'
    return view_exam_results(event)
  end
  
  def view_lecture_results(lecture)
    render 'lecture/results'
  end
  
  def view_exam_results(exam)
    render 'exam/results'
  end
end
