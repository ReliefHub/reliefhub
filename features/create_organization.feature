Feature: Add/Edit a new organization
As an administrator
I want to be able to Add/Edit/List an organization

  Scenario: View organizations
    Given the following organizations exist:
      | name        | street1          | contact person |
      | fred's ngo  | 123 main st      | alex           |
      | oscar's ngo | 455 fifth avenue | alex           |
      | sarah's ngo | 131 first st     | yan            |
    And the following projects exists:
      | name      | organization      |
      | relief 1  | name: fred's ngo  |
      | relief 2  | name: fred's ngo  |
      | relief 3  | name: oscar's ngo |
    Given I go to the admin organizations page
    Then I should see "Organizations" within "h1"
     And I should see "Organizations" within "#right-menu"
     And I should see "Projects" within "#right-menu"
     And I should see "Users" within "#right-menu"
     And I should see "Organizations" tab ".selected" within "#right-menu"
     And I should see the following organizations table:
      | name         | address          | contact person | # of projects |
      | fred's ngo   | 123 main st      | alex           | 2             |
      | oscar's ngo  | 455 fifth avenue | alex           | 1             |
      | sarah's ngo  | 131 first st     | yan            | 0             |

  Scenario: Create a new organization
	  Given I go to the admin organizations page
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

  Scenario: Edit an existing organization
	  Given the following organizations exist:
		  | name               | street1          | contact person |
		  | oliver's orphanage | 123 main st      | alex           |
		  | oscar's orphanage  | 455 fifth avenue | alex           |
		  | olivia's orphanage | 131 first st     | yan            |
    Given I go to the admin organizations page
      And I follow "oliver's orphanage"
      And I follow "Edit"
     When I fill in "Street1" with "456 lower st"
      And I fill in "City" with "New York"
      And I fill in "State" with "NY"
      And I fill in "Country" with "USA"
      And I fill in "Contact person" with "Yan"
      And I fill in "Phone number" with "012-345-6789"
      And I press "Save"
     Then I should see "Successfully changed oliver's orphanage "
      And I should see "oliver's orphanage"
      And I should see "456 lower st, New York, NY, USA"
      And I should see "Yan"

  Scenario: Create a new organization
    Given I go to the admin organizations page
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
