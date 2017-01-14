Given(/^I have an exam results link$/) do
  exam = generate_exam
  @link = "/#{exam.link2}"
end

Given(/^I am on the exam results page$/) do
  exam = generate_exam
  @link = "/#{exam.link2}"
  visit @link
end