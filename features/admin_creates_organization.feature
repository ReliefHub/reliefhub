Feature: Add/Edit a new organization

  As an admin
  I want to be able to Add/Edit/List an organization

  Background:
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles |
      | Admin      | User      | admin@test.com     | secret   | secret                | admin |

  Scenario: View organizations
    Given the following organizations exist:
      | name        | street1          | street2 | city      | state | zip   | contact person |
      | fred's ngo  | 123 main st      | apt1    | cambridge | ma    | 02121 | alex           |
      | oscar's ngo | 455 fifth avenue | apt2    | boston    | ma    | 02122 | alex           |
      | sarah's ngo | 131 first st     |         | brookline | ma    | 02123 | yan            |
    And the following projects exists:
      | name      | organization      |
      | relief 1  | name: fred's ngo  |
      | relief 2  | name: fred's ngo  |
      | relief 3  | name: oscar's ngo |
    And I sign in as "admin@test.com/secret"
    Given I go to the admin organizations page
     Then I should see "Organizations" within "h1"
      And I should see "Organizations" within "#right-menu"
      And I should see "Projects" within "#right-menu"
      And I should see "Users" within "#right-menu"
      And I should see "Organizations" tab ".selected" within "#right-menu"
      And I should see the following organizations table:
       | name         | address                                   | contact person | # of projects |
       | fred's ngo   | 123 main st, apt1, cambridge, ma, 02121   | alex           | 2             |
       | oscar's ngo  | 455 fifth avenue, apt2, boston, ma, 02122 | alex           | 1             |
       | sarah's ngo  | 131 first st, brookline, ma, 02123        | yan            | 0             |
      And I should see "Created" column following the format "[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}"

  Scenario: Create a new organization
    Given I sign in as "admin@test.com/secret"
      And I go to the admin organizations page
     When I follow "Create"
     When I fill in "Name" with "my orphanage"
      And I fill in "Street1" with "123 main st"
      And I fill in "City" with "boston"
      And I fill in "State" with "Mass"
      And I fill in "Country" with "USA"
      And I fill in "Contact person" with "alex"
      And I fill in "Phone number" with "123-456-7890"
      And I fill in "Email address" with "myorg@helppeople.com"
      And I fill in "Website" with "www.helpingpeople.com"
      And I press "Create Organization"
     Then I should see "Successfully created a new organizations called my orphanage"
      And I should see "my orphanage"
      And I should see "123 main st, boston, Mass, USA"
      And I should see "alex"

  Scenario: Edit an existing organization
    Given the following organizations exist:
      | name               | street1          | contact person |
      | oliver's orphanage | 123 main st      | alex           |
      | oscar's orphanage  | 455 fifth avenue | alex           |
      | olivia's orphanage | 131 first st     | yan            |
      And I sign in as "admin@test.com/secret"
    Given I go to the admin organizations page
      And I follow "oliver's orphanage"
      And I follow "Edit"
     When I fill in "Street1" with "456 lower st"
      And I fill in "Street2" with "Apt 4"
      And I fill in "City" with "New York"
      And I fill in "State" with "NY"
      And I fill in "Zip" with "01234"
      And I fill in "Country" with "USA"
      And I fill in "Contact person" with "Yan"
      And I fill in "Phone number" with "012-345-6789"
      And I press "Save"
     Then I should see "Successfully changed oliver's orphanage "
      And I should see "oliver's orphanage"
      And I should see "456 lower st, Apt 4, New York, NY, 01234, USA"
      And I should see "Yan"

  Scenario: Create a new organization
    Given I sign in as "admin@test.com/secret"
      And I go to the admin organizations page
     When I follow "Create"
     When I fill in "Name" with "my orphanage"
      And I fill in "Street1" with "123 main st"
      And I fill in "City" with "boston"
      And I fill in "State" with "Mass"
      And I fill in "Country" with "USA"
      And I fill in "Contact person" with "alex"
      And I fill in "Phone number" with "123-456-7890"
      And I press "Create Organization"
     Then I should see "Successfully created a new organizations called my orphanage"
      And I should see "my orphanage"
      And I should see "123 main st, boston, Mass, USA"
      And I should see "alex"

  Scenario: View all projects for an organization
    Given the following organization exists:
      | name     |
      | Some Org |
     And the following projects exist:
      | name      | organization   |
      | Project A | name: Some Org |
      | Project B | name: Some Org |
      | Project C | name: Some Org |
     And I sign in as "admin@test.com/secret"
     And I go to the admin organizations page
     And I follow "Some Org"
    Then I should see "Project A"
     And I should see "Project B"
     And I should see "Project C"

  Scenario: Anonymous user attempts to view admin organizations page
    Given I go to the admin organizations page
    Then I should see "Access Denied" within "h1"
    And I follow "sign in"
    Then I should see "Sign in" within "h2"

  Scenario: Field operator attempts to view admin organizations page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Garret     | Schuster  | garret@test.com    | secret   | secret                | field_operator                      |
    And I sign in as "garret@test.com/secret"
    And I go to the admin organizations page
    Then I should see "Access Denied" within "h1"
    And I follow "sign out"
    Then I should see "Signed out."

  Scenario: Organization manager attempts to view admin organizations page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Lue        | Ankunding | lue@test.com       | secret   | secret                | organization_manager                |
    And I sign in as "lue@test.com/secret"
    And I go to the admin organizations page
    Then I should see "Access Denied" within "h1"
    And I follow "sign out"
    Then I should see "Signed out."
