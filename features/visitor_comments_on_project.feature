Feature: Visitor comments on projrct

  In order to feel like part of a community
  As a visitor
  I want to comment on a project

  Scenario: Authenticated visitor comments on project
    Given the following user exists:
      | first_name | last_name | email            | 
      | John       | Smyth     | john@example.com |
    Given the following organization exists:
      | name                          |
      | Mission des Eglises Baptistes |
    And the following project exists:
      | name                | description   | funds purpose           | goal | organization                        |
      | Christmas Toy Drive | Toys for tots | New or gently used toys | 1000 | name: Mission des Eglises Baptistes |
    And I have signed in with "john@exmple.com/password"
    And I go to the "Christmas Toy Drive" project page
    And I fill in "comment_body" with "This project is close to my heart"
    And I press "Submit"
    Then I should be on the "Christmas Toy Drive" project page
    And I should see "This project is close to my heart"

  Scenario: Non authenticated visitor comments on project
    Given the following user exists:
      | first_name | last_name | email            | 
      | John       | Smyth     | john@example.com |
    Given the following organization exists:
      | name                          |
      | Mission des Eglises Baptistes |
    And the following project exists:
      | name                | description   | funds purpose           | goal | organization                        |
      | Christmas Toy Drive | Toys for tots | New or gently used toys | 1000 | name: Mission des Eglises Baptistes |
    And I go to the "Christmas Toy Drive" project page
    Then I should not see "Submit"
    And I should see "Sign in to leave a comment"
