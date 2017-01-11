require 'rails_helper'

RSpec.describe EventController, type: :controller do

  # index page /
  describe "GET #new" do
    
    # always returns HTTP success (200)
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  # sample event
  let(:event) { build :event }
  # sample available time
  let(:available_time) {
    from = Time.now.beginning_of_day + 8.hours
    to = from + 30.minutes
    AvailableTime.new(from: from, to: to)
  }
  
  # POST /event
  describe "POST #create" do
    %w(lecture exam).each do |event_type|
      context "create #{event_type}" do
        before :each do
          # to this action event#create send event attributes and available times
          event.event_type = event_type
          post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i], "g-recaptcha-response" => "valid"
        end
        
        # it should give status redirect
        it "returns http redirect" do
          expect(response).to have_http_status(:redirect)
        end
        
        # it should redirect us to success page
        it "redirects to event#created" do
          expect(response).to redirect_to(controller: :event, action: :created, id: assigns(:event))
        end
        
        # it should create the new event
        it "creates a new event" do
          # detect difference of exactly +1 events in database
          expect {
            post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i], "g-recaptcha-response" => "valid"
          }.to change(Event, :count).by(1)
        end
        
        context "with invalid recaptcha" do
          it "renders template review" do
            post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i], "g-recaptcha-response" => "invalid"
            expect(response).to render_template("#{event_type}/review")
          end
        end
      end
    end
  end

  # success page /event/created/:id
  describe "GET #created" do
    it "returns http success" do
      # generate ID for this event by saving in database
      event.save
      # get success page for this ID
      get :created, id: event
      # it should give us status success
      expect(response).to have_http_status(:success)
    end
  end
  
  # /event/participate/:id
  describe "POST #participate" do
    let(:student) { build :student }
    
    before :each do
      event.save
      post :participate, id: event.id, name: student.name, suitable: [8.hours], not_suitable: [8.hours + 30.minutes]
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "renders :participated template" do
      expect(response).to render_template(:participated)
    end
    
    it "creates new student" do
      expect {
        post :participate, id: event.id, name: student.name, suitable: [8.hours], not_suitable: [8.hours + 30.minutes]
      }.to change(Student, :count).by(1)
    end
  end
  
  # special links
  describe "GET #special_link" do
    
    before :each do
      # sample result data
      student = create :student, event: event
      create :selected_time, student: student
    end
    
    # invalid link
    context "invalid link" do
      it "raises routing error (Not Found)" do
        expect {
          get :special_link, link: 'invalid'
        }.to raise_error(ActionController::RoutingError)
      end
    end
    
    # special link for a lecture
    context "lecture special link" do
      before :each do
        event.event_type = 'lecture'
        event.save
      end
      
      # participate (link1)
      context "participate" do
        before :each do
          get :special_link, link: event.link1
        end
        
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
        
        it "renders the lecture/participate template" do
          expect(response).to render_template('lecture/participate')
        end
      end
      
      # view results (link2)
      context "view results" do
        before :each do
          get :special_link, link: event.link2
        end
        
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
        
        it "renders the lecture/results template" do
          expect(response).to render_template('lecture/results')
        end
      end
    end
    
    # special link for an exam
    context "exam special link" do
      before :each do
        event.event_type = 'exam'
        event.save
      end
      
      # participate (link1)
      context "participate" do
        before :each do
          get :special_link, link: event.link1
        end
        
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
        
        it "renders the exam/participate template" do
          expect(response).to render_template('exam/participate')
        end
      end
      
      # view results (link2)
      context "view results" do
        before :each do
          get :special_link, link: event.link2
        end
        
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
        
        it "renders the exam/results template" do
          expect(response).to render_template('exam/results')
        end
      end
    end
    
  end

end
