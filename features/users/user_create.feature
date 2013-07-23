Feature: admin creates users
  In order to create a new user account
  As an admin
  I want to be able to create a new user

    @vcr
    Scenario: Creates user with valid data
      Given I am logged in as an admin
      When I access the create user page
      And submit with valid user data
      Then I should see a successful user created message

    Scenario: Creates user with invalid email
      Given I am logged in as an admin
      When I access the create user page
      And submit with an invalid email
      Then I should see an invalid email message

    Scenario: Creates user without password
      Given I am logged in as an admin
      When I access the create user page
      And submit without a password
      Then I should see a missing password message

    Scenario: Creates user without password confirmation
      Given I am logged in as an admin
      When I access the create user page
      And submit without a password confirmation
      Then I should see a missing password confirmation message

    Scenario: Creates user with mismatched password and confirmation
      Given I am logged in as an admin
      When I access the create user page
      And submit with a mismatched password confirmation
      Then I should see a mismatched password message

    Scenario: Cannot create new users if not signed in
      Given I am not logged in
      When I access the create user page
      Then I should see be denied access

    Scenario: Cannot create new users if you are not an admin
      Given I am logged in as a dj
      When I access the create user page
      Then I should see be denied access

    @vcr
    Scenario: Creates user with multiple roles
      Given I am logged in as an admin
      When I access the create user page
      And submit with multiple roles
      Then I should see a successful user created message
