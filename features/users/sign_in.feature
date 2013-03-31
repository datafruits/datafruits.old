Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User signs in successfully
      Given I exist as a user
      And I am not logged in
      When I sign in with valid credentials
      Then I should be signed in

    Scenario: User enters wrong email
      Given I exist as a user
      And I am not logged in
      When I sign in with a wrong email
      Then I should not be signed in

    Scenario: User enters wrong password
      Given I exist as a user
      And I am not logged in
      When I sign in with a wrong password
      Then I should not be signed in

    Scenario: User can sign in with username instead of email
      Given I exist as a user
      And I am not logged in
      When I sign in with valid credentials using username instead of email
      Then I should be signed in
