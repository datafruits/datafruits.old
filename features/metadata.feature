Feature: get metadata

  Scenario: get metadata json
    Given the radio server is up
    When I request the metadata
    Then I should get the metadata in a json response
