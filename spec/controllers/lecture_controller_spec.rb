require 'rails_helper'

RSpec.describe LectureController, type: :controller do
  
  # page /lecture/new
  describe "GET #new" do
    before :each do
      get :new
    end
    
    # should give us status http success (200)
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    # should render /lecture/new template (new lecture form)
    it "renders the :new template" do
      expect(response).to render_template('new')
    end
    
    # assign empty global variable @lecture
    it "assigns a new @lecture" do
      expect(assigns(:lecture)).to be_a_new(Event).with(event_type: 'lecture')
    end
  end

  # sample lecture
  let(:lecture) { build :event, event_type: 'lecture' }

  # POST /lecture/review
  describe "POST #review" do
    # send this action lecture#review lecture attributes and sample available times (day[], from[], to[])
    before :each do
      post :review,
            event: lecture.attributes.except(:event_type),
            day: ['monday'],
            from: [8.hours],
            to: [8.hours + 30.minutes]
    end
    
    # should give us status http success (200)
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :new template with invalid attributes" do
      lecture.email = nil
      post :review, event: lecture.attributes.except(:event_type),
            day: ['monday'],
            from: [8.hours],
            to: [8.hours + 30.minutes]
      expect(response).to render_template('new')
    end
    
    # should render /lecture/review template (timetable)
    it "renders the :review template" do
      expect(response).to render_template('review')
    end
  end

end
