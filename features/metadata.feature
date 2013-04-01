Feature: get metadata

  @redis
  Scenario: get metadata json
    Given metadata is set in redis
    When I request the metadata
    Then I should get the metadata in a json response
