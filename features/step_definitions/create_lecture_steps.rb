Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

Then(/^I should be taken to the new lecture form$/) do
  expect(page).to have_content("Schedule a new lecture")
  expect(page).to have_selector("form.new_event")
end

Given(/^I am on the new lecture form$/) do
  visit new_lecture_path
end

When(/^I fill in the form with lecture data$/) do
  fill_in "Event Title:", with: "Math Lecture"
  fill_in "Description:", with: "A lecture on calculus"
  fill_in "E-Mail:", with: "professor@university.edu"
  select "1", from: "Number of times per week:"
  select "1:00", from: "Duration:"
  select "Monday", from: "day[]"
  select "9:00 A.M.", from: "from[]"
  select "10:00 A.M.", from: "to[]"
end

Then(/^I should be taken to the lecture timetable review$/) do
  expect(page).to have_content("Lectures Table")
end

Then(/^I should be taken to the success page for professors$/) do
  expect(page).to have_content("Your event has been created.")
end