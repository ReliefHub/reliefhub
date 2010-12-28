Feature: Admin visits home page

  In order to manage the ReliefHub site
  As an admin
  I want to see the "Admin" link on the home page.

  Scenario: Admin visits home page
    Given the following user exists:
      | first_name | last_name | email              | password | password_confirmation | roles |
      | Admin      | User      | admin@test.com     | secret   | secret                | admin |
    And I sign in as "admin@test.com/secret"
    And I am on the homepage
    And I should see "Admin"
