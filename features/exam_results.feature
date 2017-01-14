Feature: View exam participation results
  I am a professor. I should be able to see which students have participated
  in my exam if I have the results link.

Scenario: See exam results page
  Given I have an exam results link
  When I visit the link
  Then I should be able to see the results page

Scenario: See student names
  Given I am on the exam results page
  Then I should be able to see which students have participated

@javascript
Scenario: See timetable with results
  Given I am on the exam results page
  Then I should be able to see the timetable with the results

@javascript
Scenario: Hide/Show student
  Given I am on the exam results page
  Then I should be able to see the timetable with the results
  And I click "Hide/Show"
  Then The results timetable should change