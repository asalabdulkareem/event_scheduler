require 'rails_helper'

RSpec.describe ExamController, type: :controller do

  # page /exam/new
  describe "GET #new" do
    before :each do
      get :new
    end
    
    # should give us status http success (200)
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    # should render /exam/new template (new exam form)
    it "renders the :new template" do
      expect(response).to render_template('new')
    end
    
    # assign empty global variable @exam
    it "assigns a new @exam" do
      expect(assigns(:exam)).to be_a_new(Event).with(event_type: 'exam')
    end
  end
  
  # sample exam
  let(:exam) { build :event, event_type: 'exam' }

  # POST /exam/review
  describe "POST #review" do
    before :each do
      # send this action exam#review exam attributes and sample available times (date[], from[], to[])
      post :review, event: exam.attributes.except(:event_type),
            date: [Date.today],
            from: [8.hours],
            to: [8.hours + 30.minutes]
    end
    
    # should give us status http success (200)
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    # should render /exam/review template (timetable)
    it "renders the :review template" do
      expect(response).to render_template('review')
    end
  end

end
