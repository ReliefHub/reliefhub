Feature: View ReliefHub user list
  As a ReliefHub admin user
  I want to be able to view all existing user accounts

  Scenario: View users
    Given the following users exist:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Julio      | Kulas     | julio@test.com     | secret   | secret                |                                     |
      | Garret     | Schuster  | garret@test.com    | secret   | secret                | field_operator                      |
      | Lue        | Ankunding | lue@test.com       | secret   | secret                | organization_manager                |
      | Cassandra  | Goodwin   | cassandra@test.com | secret   | secret                | organization_manager field_operator |
      | Admin      | User      | admin@test.com     | secret   | secret                | admin                               |
    And I sign in as "admin@test.com/secret"
    And I go to the admin users page
    Then I should see "Users" within "h1"
    And I should see "Organizations" within "#right-menu"
    And I should see "Projects" within "#right-menu"
    And I should see "Users" within "#right-menu"
    And I should see "Users" tab ".selected" within "#right-menu"
    And I should see the following users table:
      | User Name         | Field Operator | Orphanage Manager | Site Administrator |
      | Lue Ankunding     | Disabled       | Enabled           | Disabled           |
      | Cassandra Goodwin | Enabled        | Enabled           | Disabled           |
      | Julio Kulas       | Disabled       | Disabled          | Disabled           |
      | Garret Schuster   | Enabled        | Disabled          | Disabled           |
      | Admin User        | Disabled       | Disabled          | Enabled            |
    And I should see "Created" column following the format "[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}"

  Scenario: Anonymous user attempts to view users
    Given I go to the admin users page
    Then I should see "Access Denied" within "h1"
    And I follow "sign in"
    Then I should see "Sign in" within "h2"

  Scenario: Field operator user attempts to view admin users page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Garret     | Schuster  | garret@test.com    | secret   | secret                | field_operator                      |
    And I sign in as "garret@test.com/secret"
    And I go to the admin users page
    Then I should see "Access Denied" within "h1"
    And I follow "sign out"
    Then I should see "Signed out."

  Scenario: Organziation manager user attempts to view admin users page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles                               |
      | Lue        | Ankunding | lue@test.com       | secret   | secret                | organization_manager                |
    And I sign in as "lue@test.com/secret"
    And I go to the admin users page
    Then I should see "Access Denied" within "h1"
    And I follow "sign out"
    Then I should see "Signed out."
