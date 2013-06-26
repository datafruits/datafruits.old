Feature: Scheduling shows

  @vcr
  Scenario: Signed in user creates a new show
    Given I am signed in as a user with the 'dj' role
    When I create a new show
    Given the date is 2013-03-28
    Then I should see my show appear on the schedule

  Scenario: Admin creates show for other user
    Given I am logged in as an admin
    And a user with the 'dj' role exists
    When I create a show and fill in the user id
    Given the date is 2013-03-28
    Then I should see that show for that user appear on the schedule

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
    Given the date is 2013-03-28
    When I visit '/schedule'
    Then I should see the list of upcoming broadcasts
