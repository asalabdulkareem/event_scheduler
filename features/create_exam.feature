Feature: Create Exam
  I am a professor. I should be able to create a exam.

Scenario: See new exam form
  Given I am on the homepage
  When I click "Schedule an Exam"
  Then I should be taken to the new exam form

Scenario: See exam timetable review
  Given I am on the new exam form
  When I fill in the form with exam data
  And I click "Next"
  Then I should be taken to the exam timetable review
  
Scenario: Create new exam
  Given I am on the new exam form
  When I fill in the form with exam data
  And I click "Next"
  Then I should be taken to the exam timetable review
  And I click "Submit"
  Then I should be taken to the success page for professors
  