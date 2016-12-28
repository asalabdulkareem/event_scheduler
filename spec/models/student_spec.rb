require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:event) { Event.new(event_type: "lecture",
                          lecture_title: "math",
                          description: "Calculus Lecture",
                          email: "professor@university.edu",
                          num_times: 1,
                          duration: 1.5)
  }
  subject { described_class.new name: "Ahmad", event: event }
  
  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "should not be valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  
  it "should not be valid without event" do
    subject.event = nil
    expect(subject).to_not be_valid
  end
  
end
