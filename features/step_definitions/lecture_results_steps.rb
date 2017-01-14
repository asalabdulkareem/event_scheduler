Then(/^I should be able to see the results page$/) do
  expect(page).to have_content(/(Lecture|Exam) Time Result/)
end

Then(/^I should be able to see which students have participated$/) do
  expect(page).to have_css("table.participants")
  expect(page).to have_content("List of participants:")
end

Then(/^I should be able to see the timetable with the results$/) do
  expect(page).to have_content("Time/Date")
  expect(page).to have_css("table.timetable")
  expect(page).to have_css("span.num-suitable")
  @timetable = find("table.timetable")["innerHTML"]
end

Then(/^The results timetable should change$/) do
  new_timetable = find("table.timetable")["innerHTML"]
  expect(new_timetable).not_to eq(@timetable)
end

Given(/^I have a lecture results link$/) do
  lecture = generate_lecture
  @link = "/#{lecture.link2}"
end

Given(/^I am on the lecture results page$/) do
  lecture = generate_lecture
  @link = "/#{lecture.link2}"
  visit @link
end