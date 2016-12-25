require 'rails_helper'

RSpec.describe EventController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #success" do
    let(:exam) {
      Event.create(event_type: "exam",
                lecture_title: "math",
                description: "Calculus Lecture",
                email: "professor@university.edu",
                num_times: 1,
                duration: 1.5)
    }
    it "returns http success" do
      get :success, id: exam
      expect(response).to have_http_status(:success)
    end
  end

end
