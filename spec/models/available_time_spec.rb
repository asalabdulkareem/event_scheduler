require 'rails_helper'

RSpec.describe AvailableTime, type: :model do
  let(:event) { Event.new(event_type: "lecture",
                          lecture_title: "math",
                          description: "Calculus Lecture",
                          email: "professor@university.edu",
                          num_times: 1,
                          duration: 1.5)
  }
  subject { described_class.new(event: event,
                                from: Time.now.beginning_of_week,
                                to: Time.now.beginning_of_week + 30.minutes)
  }
  
  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "should not be valid without start time" do
    subject.from = nil
    expect(subject).to_not be_valid
  end
  
  it "should not be valid without end time" do
    subject.to = nil
    expect(subject).to_not be_valid
  end
  
  it "should not be valid if start time is after end time" do
    subject.from = Time.now.beginning_of_week
    subject.to = subject.from - 1.hour
    expect(subject).to_not be_valid
  end
  
  it "should not be valid if start time is not 30-minute aligned" do
    # we are sure Time.now.beginning_of_week is 30-minute aligned
    # because it's exactly this week's monday midnight (00:00)
    # thus we are testing case 00:01
    subject.from = Time.now.beginning_of_week + 1.second
    expect(subject).to_not be_valid
  end
  
  it "should not be valid if end time is not 30-minute aligned" do
    subject.to = Time.now.beginning_of_week + 1.second
    expect(subject).to_not be_valid
  end
    
end
