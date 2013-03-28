Feature: Scheduling shows

  Background:
    Given the date is 2013-03-28

  Scenario: Signed in user creates a new show
    Given I am signed in as a user with the 'dj' role
    When I create a new show
    Then I should see my show appear on the schedule

  Scenario: Signed in user cancels their show
    Given I am signed in as a user with the 'dj' role
    And a show exists
    When I cancel my show
    Then I should see my show appear as cancelled

  Scenario: Signed in user edits their show
    Given I am signed in as a user with the 'dj' role
    And a show exists
    When I edit my show's details
    Then I should see the show's details are updated

  Scenario: Visitor sees scheduled proramming
    Given I am a visitor to the site
    And a show exists
    When I visit '/schedule'
    Then I should see the list of upcoming broadcasts
