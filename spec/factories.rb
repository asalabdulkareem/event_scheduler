FactoryGirl.define do
  factory :event do
    event_type "lecture"
    lecture_title "math"
    description "Calculus Lecture"
    email "professor@university.edu"
    num_times 1
    duration 1.5
  end
end