def generate_exam
  exam = FactoryGirl.build(:event)
  exam.event_type = 'exam'
  exam.save
  FactoryGirl.create(:available_time, event: exam)
  return exam
end

Given(/^I have an exam participation link$/) do
  exam = generate_exam
  @link = "/#{exam.link1}"
end

Then(/^I should see the exam participation timetable$/) do
  expect(page).to have_content(/You are invited to .* exam/)
end

Given(/^I am on the exam participation page$/) do
  exam = generate_exam
  @link = "/#{exam.link1}"
  visit @link
end