Feature: Blogging

  Scenario: Viewing a post
    Given I am a visitor to the site
    And some blog posts exist
    When I visit the front page
    Then I should see some blog posts

  Scenario: Deleting a post
    Given I am signed in as a user with the 'blogger' role
    And a blog post exists
    When I delete the post
    Then I should not see that blog post

  @vcr
  Scenario: Creating a new post
    Given I am signed in as a user with the 'blogger' role
    When I submit a new blog post
    Then I should see my new blog post

  Scenario: Editing a post
    Given I am signed in as a user with the 'blogger' role
    And a blog post exists
    When I edit the post
    Then I should see my changes to the post
