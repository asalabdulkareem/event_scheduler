require 'rails_helper'

RSpec.describe EventController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :new template"
  end

end
