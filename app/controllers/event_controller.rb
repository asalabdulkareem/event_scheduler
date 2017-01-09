class EventController < ApplicationController
  def new
  end
  
  # handle special link for participation or viewing results
  def special_link
    link = params[:link]
    
    # participation link?
    event = Event.find_by(link1: link)
    if event
      return participate_lecture(event) if event.event_type == 'lecture'
      return participate_exam(event)
    end
    
    # view results link?
    event = Event.find_by(link2: link)
    if event
      return view_lecture_results(event) if event.event_type == 'lecture'
      return view_exam_results(event)
    end
    
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
      
      # send email
      if @event.event_type == 'lecture'
        UserMailer.lecture_created(@event).deliver_now
      else
        UserMailer.exam_created(@event).deliver_now
      end
      redirect_to action: :created, id: @event
    end
  end
  
  # participate in the event with given ID as student with name and selected times (suitable and not suitable)
  def participate
    @event = Event.find params[:id]
    @student = Student.new(name: params[:name], event: @event)
    params[:suitable].each { |time| @student.selected_times.new(from: Time.at(time.to_i), suitable: true) } if params.include?(:suitable)
    params[:not_suitable].each { |time| @student.selected_times.new(from: Time.at(time.to_i), suitable: false) } if params.include?(:not_suitable)
    @student.save
    puts @student.errors.messages
    render 'participated'
  end

  # CRUD read for events
  # find saved event with id params[:id] and display success page
  def created
    @event = Event.find params[:id]
  end
  
  private
  
  # allowed POST parameters
  def event_params
    params.require(:event)
      .permit(:event_type, :lecture_title, :description, :email, :num_times, :duration)
  end
  
  # server side recaptcha verification
  def verify_recaptcha(response)
    return true if Rails.env.test?
    require 'net/http'
    uri = URI('https://www.google.com/recaptcha/api/siteverify')
    res = Net::HTTP.post_form(uri, 'secret' => Rails.application.secrets.RECAPTCHA_SECRET, 'response' => response)
    return JSON.parse(res.body)['success']
  end
  
  # participate in lecture
  def participate_lecture(lecture)
    @lecture = lecture
    @timetable = AvailableTime.lecture_timetable(lecture.available_times)
    render 'lecture/participate'
  end
  
  # participate in exam
  def participate_exam(exam)
    @exam = exam
    @timetable = AvailableTime.exam_timetable(exam.available_times)
    render 'exam/participate'
  end
  
  # view results for lecture
  def view_lecture_results(lecture)
    @lecture = lecture
    @timetable = AvailableTime.lecture_timetable(lecture.available_times)
    render 'lecture/results'
  end
  
  # view results for exam
  def view_exam_results(exam)
    render 'exam/results'
  end
end
