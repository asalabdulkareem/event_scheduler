Feature: Participate in Lecture
  I am a student. I should be able to participate on a lecture if I have the link.

Scenario: See lecture participation timetable
  Given I have a lecture participation link
  When I visit the link
  Then I should see the lecture participation timetable

@javascript
Scenario: Select suitable times
  Given I am on the lecture participation page
  When I click on an available cell once
  Then The cell should turn green
  
@javascript
Scenario: Select not suitable times 
  Given I am on the lecture participation page
  When I click on an available cell twice
  Then The cell should turn red
  
@javascript
Scenario: Select times and participate
  Given I am on the lecture participation page
  When I click on an available cell once
  And I fill in the name field with "John Smith"
  And I click "Submit"
  Then I should be taken to the success page for students
  