Feature: Participate in Exam
  I am a student. I should be able to participate on an exam if I have the link.

Scenario: See exam participation timetable
  Given I have an exam participation link
  When I visit the link
  Then I should see the exam participation timetable

@javascript
Scenario: Select suitable times
  Given I am on the exam participation page
  When I click on an available cell once
  Then The cell should turn green
  
@javascript
Scenario: Select not suitable times 
  Given I am on the exam participation page
  When I click on an available cell twice
  Then The cell should turn red
  
@javascript
Scenario: Select times and participate
  Given I am on the exam participation page
  When I click on an available cell once
  And I fill in the name field with "John Smith"
  And I click "Submit"
  Then I should be taken to the success page for students
  