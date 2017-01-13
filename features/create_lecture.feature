Feature: Create Lecture
  I am a professor. I should be able to create a lecture.

Scenario: See new lecture form
  Given I am on the homepage
  When I click "Schedule a Lecture"
  Then I should be taken to the new lecture form

Scenario: See lecture timetable review
  Given I am on the new lecture form
  When I fill in the form with lecture data
  And I click "Next"
  Then I should be taken to the lecture timetable review
  
Scenario: Create new lecture
  Given I am on the new lecture form
  When I fill in the form with lecture data
  And I click "Next"
  Then I should be taken to the lecture timetable review
  And I click "Submit"
  Then I should be taken to the success page for professors
  