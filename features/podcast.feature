Feature: Podcasts

  @vcr
  Scenario: Admin uploads a podcast
    Given I am logged in as an admin
    And a user with the 'dj' role exists
    When I create a podcast and fill in the user id
    Then I should see that show in the podcasts

  @vcr
  Scenario: Admin edits podcast
    Given I am logged in as an admin
    And some podcasts exist
    When I visit the podcast edit page and edit some details
    Then I should see that updated show in the podcasts

  @vcr
  Scenario: Download podcast xml
    Given I am a visitor to the site
    And some podcasts exist
    When I visit '/podcast.xml'
    Then I should get the podcast feed in xml format
