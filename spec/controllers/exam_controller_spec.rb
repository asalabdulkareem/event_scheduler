require 'rails_helper'

RSpec.describe ExamController, type: :controller do

  describe "GET #new" do
    before :each do
      get :new
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :new template" do
      expect(response).to render_template('new')
    end
    
    it "assigns a new @exam" do
      expect(assigns(:exam)).to be_a_new(Event).with(event_type: 'exam')
    end
  end
  
  let(:exam) { build :event, event_type: 'exam' }

  describe "POST #review" do
    before :each do
      post :review, event: exam.attributes.except(:event_type),
            date: [Date.today],
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

end
