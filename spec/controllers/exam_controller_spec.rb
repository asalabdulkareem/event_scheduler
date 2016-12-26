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
  
  let(:exam) {
    Event.new(event_type: "exam",
              lecture_title: "math",
              description: "Calculus Lecture",
              email: "professor@university.edu",
              num_times: 1,
              duration: 1.5)
  }

  describe "POST #review" do
    before :each do
      post :review, exam: exam.attributes.except(:event_type)
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :review template" do
      expect(response).to render_template('review')
    end
  end

end
