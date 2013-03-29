Feature: Sign up
  In order to create a new user account
  As an admin
  I want to be able to sign up a new user

    @vcr
    Scenario: Signs up user with valid data
      Given I am logged in as an admin
      When I sign up with valid user data
      Then I should see a successful sign up message

    Scenario: Signs up user with invalid email
      Given I am logged in as an admin
      When I sign up with an invalid email
      Then I should see an invalid email message

    Scenario: Signs up user without password
      Given I am logged in as an admin
      When I sign up without a password
      Then I should see a missing password message

    Scenario: Signs up user without password confirmation
      Given I am logged in as an admin
      When I sign up without a password confirmation
      Then I should see a missing password confirmation message

    Scenario: Signs up user with mismatched password and confirmation
      Given I am logged in as an admin
      When I sign up with a mismatched password confirmation
      Then I should see a mismatched password message

    Scenario: Cannot create new users if not signed in
      Given I am not logged in
      When I access the sign up page
      Then I should see be denied access

    Scenario: Cannot create new users if you are not an admin
      Given I am logged in as a dj
      When I access the sign up page
      Then I should see be denied access
