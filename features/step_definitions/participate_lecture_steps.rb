def generate_lecture
  lecture = FactoryGirl.build(:event)
  lecture.event_type = 'lecture'
  lecture.save
  FactoryGirl.create(:available_time, event: lecture)
  return lecture
end

Given(/^I have a lecture participation link$/) do
  lecture = generate_lecture
  @link = "/#{lecture.link1}"
end

When(/^I visit the link$/) do
  visit @link
end

Then(/^I should see the lecture participation timetable$/) do
  expect(page).to have_content(/You are invited to .* lecture/)
end

Given(/^I am on the lecture participation page$/) do
  lecture = generate_lecture
  @link = "/#{lecture.link1}"
  visit @link
end

When(/^I click on an available cell once$/) do
  @available_cell = find(".available")
  @available_cell.click
end

Then(/^The cell should turn green$/) do
  expect(@available_cell).to match_css(".suitable")
end

When(/^I click on an available cell twice$/) do
  @available_cell = find(".available")
  @available_cell.click
  @available_cell.click
end

Then(/^The cell should turn red$/) do
  expect(@available_cell).to match_css(".not-suitable")
end

When(/^I fill in the name field with "([^"]*)"$/) do |name|
  @name = name
  fill_in "name", with: @name
end

Then(/^I should be taken to the success page for students$/) do
  expect(page).to have_content("Thanks, #{@name} For your participation in this event.")
end
