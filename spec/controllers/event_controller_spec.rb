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
    before :each do
      # to this action event#create send event attributes and available times
      post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i]
    end
    
    # it should give status redirect
    it "returns http redirect" do
      expect(response).to have_http_status(:redirect)
    end
    
    # it should redirect us to success page
    it "redirects to event#success" do
      expect(response).to redirect_to(controller: :event, action: :success, id: assigns(:event))
    end
    
    # it should create the new event
    it "creates a new event" do
      # detect difference of exactly +1 events in database
      expect {
        post :create, event: event.attributes, from: [available_time.from.to_i], to: [available_time.to.to_i]
      }.to change(Event, :count).by(1)
    end
  end

  # success page /event/success/:id
  describe "GET #success" do
    it "returns http success" do
      # generate ID for this event by saving in database
      event.save
      # get success page for this ID
      get :success, id: event
      # it should give us status success
      expect(response).to have_http_status(:success)
    end
  end

end
