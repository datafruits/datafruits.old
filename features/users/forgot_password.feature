Feature: user resets forgotten password
  Scenario: user clicks password reset link
    Given a user exists
    And she clicks the forgotten password link
    Then she should recieve an email to reset their password
