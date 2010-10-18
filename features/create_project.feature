Feature: Create a project
  In order to collect donations
  An admin user should be able to create a project

  Scenario: View all projects
    Given the following projects exist:
      | name      |
      | Project A |
      | Project B |
      | Project C |
    And I go to the admin projects page
    Then I should see "Project A"
    And I should see "Project B"
    And I should see "Project C"

  Scenario: Create a new project
    Given I go to the admin projects page
    When I follow "Create"
    When I fill in "Name" with "Test Project"
    And I press "Create Project"
    Then I should see "Successfully created a new project called Test Project"

  Scenario: Edit an existing project
    Given the following projects exist:
      | name      |
      | Project A |
    And I go to the admin projects page
    When I follow "Edit"
    When I fill in "Name" with "Test Project 2"
    And I press "Save Project"
    Then I should see "Successfully saved changes"
