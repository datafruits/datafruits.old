Feature: Sign in via api

    Scenario: User logs in via json
      Given I exist as a user
      And I am not logged in
      When I sign in with valid credentials via json
      Then I should get a 'signed in' json response
