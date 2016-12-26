require 'rails_helper'

RSpec.describe LectureController, type: :controller do
  describe "GET #new" do
    before :each do
      get :new
    end
    
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :new template" do
      expect(response).to render_template('new')
    end
    
    it "assigns a new @lecture" do
      expect(assigns(:lecture)).to be_a_new(Event).with(event_type: 'lecture')
    end
  end

  let(:lecture) {
    Event.new(event_type: "lecture",
              lecture_title: "math",
              description: "Calculus Exam",
              email: "professor@university.edu",
              num_times: 1,
              duration: 1.5)
  }

  describe "POST #review" do
    before :each do
      post :review,
            event: lecture.attributes.except(:event_type),
            day: ['monday'],
            from: [8.hours],
            to: [8.hours + 30.minutes]
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :review template" do
      expect(response).to render_template('review')
    end
  end

  # describe "POST #create" do
  #   before :each do
  #     post :create, lecture: lecture.attributes
  #   end
    
  #   it "returns http redirect" do
  #     expect(response).to have_http_status(:redirect)
  #   end
    
  #   it "redirects to event#success" do
  #     expect(response).to redirect_to(controller: :event, action: :success, id: assigns(:lecture))
  #   end
    
  #   it "creates a new lecture" do
  #     expect {
  #       post :create, lecture: lecture.attributes
  #     }.to change(Event, :count).by(1)
  #   end
  # end

end
