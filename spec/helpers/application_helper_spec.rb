require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#seconds_to_12_hour_time" do
    it "returns correct AM time" do
      expect(helper.seconds_to_12_hour_time(8.hours.to_i)).to eq("8:00 A.M.")
    end
    
    it "returns correct PM time" do
      expect(helper.seconds_to_12_hour_time(13.hours.to_i)).to eq("1:00 P.M.")
    end
    
    it "returns 12:00 P.M." do
      expect(helper.seconds_to_12_hour_time(12.hours.to_i)).to eq("12:00 P.M.")
    end
  end
  
  describe "#float_to_time" do
    it "returns correct formatted time" do
      expect(helper.float_to_time(8.5)).to eq("8:30")
    end
  end
  
  describe "#generate_hour_options" do
    it "generates correct options" do
      options = helper.generate_hour_options
      expect(options).to match(/(<option value="\d+">\d{1,2}:\d{2} (A|P)\.M\.<\/option>\n?)+/)
    end
  end
end