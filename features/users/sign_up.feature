Feature: Sign up
  In order to create a new user account
  I want to be able to sign up

    @vcr
    Scenario: Signs up user with valid data
      When I access the sign up page
      And submit with valid user data
      Then I should see a successful sign up message

    Scenario: Signs up user with invalid email
      When I access the sign up page
      And submit with an invalid email
      Then I should see an invalid email message

    Scenario: Signs up user without password
      When I access the sign up page
      And submit without a password
      Then I should see a missing password message

    Scenario: Signs up user without password confirmation
      When I access the sign up page
      And submit without a password confirmation
      Then I should see a missing password confirmation message

    Scenario: Signs up user with mismatched password and confirmation
      When I access the sign up page
      And submit with a mismatched password confirmation
      Then I should see a mismatched password message
