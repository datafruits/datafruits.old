Feature: Edit User

    @vcr
    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see my account was edited

    @vcr
    Scenario: Admin can edit users without specifying their password
      Given I am logged in as an admin
      And a user exists
      When I edit that users account details without filling in their passwords
      Then I should see the account was edited
