require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build :event }
  
  # should be valid by default
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  # should not be valid if event type missing
  it "is not valid without event type" do
    subject.event_type = nil
    expect(subject).to_not be_valid
  end
  
  # should not be valid if lecture title missing
  it "is not valid without lecture title" do
    subject.lecture_title = nil
    expect(subject).to_not be_valid
  end
  
  # should not be valid if description missing
  it "is not valid without description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  
  # should not be valid if email missing
  it "is not valid without email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  
  # should not be valid if duration missing
  it "is not valid without duration" do
    subject.duration = nil
    expect(subject).to_not be_valid
  end
  
  # should generate link1
  it "should automatically generate link1" do
    expect(subject.link1).to_not be_nil
  end
  
  # should generate link2
  it "should automatically generate link2" do
    expect(subject.link2).to_not be_nil
  end
  
  # tests specific for lecture type events
  describe "Lecture" do
    before { subject.event_type = "lecture" }
  
    it "is not valid without number of times per week" do
      subject.num_times = nil
      expect(subject).to_not be_valid
    end
  end
  
  # tests specific for exam type events
  describe "Exam" do
    before { subject.event_type = "exam" }
  
    it "is valid without number of times per week" do
      subject.num_times = nil
      expect(subject).to be_valid
    end
  end
    
  
end
