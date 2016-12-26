require 'rails_helper'

RSpec.describe EventController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  let(:event) {
    Event.new(event_type: "lecture",
              lecture_title: "math",
              description: "Calculus Lecture",
              email: "professor@university.edu",
              num_times: 1,
              duration: 1.5)
  }
  let(:available_time) {
    from = Time.now.beginning_of_day + 8.hours
    to = from + 30.minutes
    AvailableTime.new(from: from, to: to)
  }
  
  describe "POST #create" do
    before :each do
      post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i]
    end
    
    it "returns http redirect" do
      expect(response).to have_http_status(:redirect)
    end
    
    it "redirects to event#success" do
      expect(response).to redirect_to(controller: :event, action: :success, id: assigns(:event))
    end
    
    it "creates a new event" do
      expect {
      post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i]
      }.to change(Event, :count).by(1)
    end
  end

  describe "GET #success" do
    it "returns http success" do
      event.save
      get :success, id: event
      expect(response).to have_http_status(:success)
    end
  end

end
