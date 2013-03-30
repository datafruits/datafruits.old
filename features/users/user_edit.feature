Feature: Edit User

    @vcr
    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see my account was edited
