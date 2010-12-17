Feature: Create a project

  In order to collect donations
  An admin should be able to create a project

  Background:
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles |
      | Admin      | User      | admin@test.com     | secret   | secret                | admin |

  Scenario: View all projects for an organization
    Given the following projects exist:
      | name      | organization   |
      | Project A | name: Some Org |
      | Project B | name: Some Org |
      | Project C | name: Some Org |
    And I sign in as "admin@test.com/secret"
    And I go to the admin page for organization "Some Org"
    Then I should see "Project A"
    And I should see "Project B"
    And I should see "Project C"

  Scenario: View projects
    Given the following organizations exist:
      | name        | street1          | contact person |
      | fred's ngo  | 123 main st      | alex           |
      | oscar's ngo | 455 fifth avenue | alex           |
      | sarah's ngo | 131 first st     | yan            |
    And the following projects exists:
      | name      | organization      | goal | status   |
      | relief 1  | name: fred's ngo  | 1015 | funded   |
      | relief 2  | name: fred's ngo  | 2042 | new      |
      | relief 3  | name: oscar's ngo | 3033 |          |
    And the following donations exists:
      | project         | amount |
      | name: relief 1  | 100    |
      | name: relief 1  | 100    |
      | name: relief 2  | 700    |
      | name: relief 2  | 300    |
    And I sign in as "admin@test.com/secret"
    Given I go to the admin projects page
    Then I should see "Projects" within "h1"
     And I should see "Organizations" within "#right-menu"
     And I should see "Projects" within "#right-menu"
     And I should see "Users" within "#right-menu"
     And I should see "Projects" tab ".selected" within "#right-menu"
     And I should see the following projects table:
      | name      | status | funds needed | funds received |
      | relief 1  | funded | $1,015.00    | $200.00        |
      | relief 2  | new    | $2,042.00    | $1,000.00      |
      | relief 3  |        | $3,033.00    | $0.00          |
     And I should see "Created" column following the format "[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}"

  Scenario: Create a new project from the organization page
    Given the following organization exists:
      | name     |
      | Some Org |
    And I sign in as "admin@test.com/secret"
    And I go to the admin organizations page
    And I follow "Some Org"
    When I follow "Create Project"
    When I fill in "Name" with "Test Project"
    And I press "Create Project"
    Then I should see "Successfully created a new project called Test Project"

  Scenario: Edit an existing project
    Given the following project exists:
      | name      | organization   |
      | Project A | name: Some Org |
    And I sign in as "admin@test.com/secret"
    And I go to the admin organizations page
    And I follow "Some Org"
    When I follow "Project A"
    When I fill in "Name" with "Test Project 2"
    And I press "Save Project"
    Then I should see "Successfully saved changes"

  Scenario: Anonymous user attempts to view admin projects page
    Given I go to the admin projects page
    Then I should see "Access Denied" within "h1"
    And I follow "sign in"
    Then I should see "Sign in" within "h2"

  Scenario: Field operator attempts to view admin projects page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Garret     | Schuster  | garret@test.com    | secret   | secret                | field_operator                      |
    And I sign in as "garret@test.com/secret"
    And I go to the admin projects page
    Then I should see "Access Denied" within "h1"
    And I follow "sign out"
    Then I should see "Signed out."

  Scenario: Organization manager attempts to view admin projects page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Lue        | Ankunding | lue@test.com       | secret   | secret                | organization_manager                |
    And I sign in as "lue@test.com/secret"
    And I go to the admin projects page
    Then I should see "Access Denied" within "h1"
    And I follow "sign out"
    Then I should see "Signed out."
