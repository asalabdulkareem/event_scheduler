require 'rails_helper'

RSpec.describe SelectedTime, type: :model do
  let(:event) {
    e = Event.create(event_type: "lecture",
                  lecture_title: "math",
                  description: "Calculus Lecture",
                  email: "professor@university.edu",
                  num_times: 1,
                  duration: 1.5)
    week_beginning = Time.now.beginning_of_week
    AvailableTime.create(event: e, from: week_beginning, to: week_beginning + 1.hour)
    return e
  }
  let(:student) { Student.new name: "John Smith", event: event }
  subject { described_class.new(student: student,
                                from: Time.now.beginning_of_week)
  }
  
  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "should not be valid without student" do
    subject.student = nil
    expect(subject).to_not be_valid
  end
  
  it "should not be valid without start time" do
    subject.from = nil
    expect(subject).to_not be_valid
  end
  
  it "should not be valid if start time is not 30-minute aligned" do
    # we are sure Time.now.beginning_of_week is 30-minute aligned
    # because it's exactly this week's monday midnight (00:00)
    # thus we are testing case 00:01
    subject.from = Time.now.beginning_of_week + 1.second
    expect(subject).to_not be_valid
  end
  
end
