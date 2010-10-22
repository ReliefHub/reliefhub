Feature: Visitor visits home page

  In order to donate to Haitian orphanage projects
  As a visitor
  I want to see projects and understand how ReliefHub works

  Scenario: Visitor visits home page
    Given the following project exists:
      | name                |
      | Christmas Toy Drive |
    And I am on the homepage
    Then I should see the ReliefHub process on the page
    And I should see blog posts on the page
    And I should see recent press on the page
    And I should see "Christmas Toy Drive"
