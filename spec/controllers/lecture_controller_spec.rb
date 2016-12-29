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

  let(:lecture) { build :event, event_type: 'lecture' }

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

end
