Then(/^I should be taken to the new exam form$/) do
  expect(page).to have_content("Schedule a new exam")
  expect(page).to have_selector("form.new_event")
end

Given(/^I am on the new exam form$/) do
  visit new_exam_path
end

When(/^I fill in the form with exam data$/) do
  fill_in "Event Title:", with: "Math Lecture"
  fill_in "Description:", with: "A lecture on calculus"
  fill_in "E-Mail:", with: "professor@university.edu"
  select "1:00", from: "Duration:"
  fill_in "date[]", with: Date.today.to_s
  select "9:00 A.M.", from: "from[]"
  select "10:00 A.M.", from: "to[]"
end

Then(/^I should be taken to the exam timetable review$/) do
  expect(page).to have_content("Exam Table")
end