Feature: Add/Edit a new organization
As an administrator
I want to be able to Add/Edit an organization


	Scenario: View organizations
	  Given the following organizations exist:
		  | name               | street1          | contact person |
		  | oliver's orphanage | 123 main st      | alex           |
		  | oscar's orphanage  | 455 fifth avenue | alex           |
		  | olivia's orphanage | 131 first st     | yan            |
	  Given I go to the organizations page
	   Then I should see "Organization"
		  And I should see "oliver's orphanage"
		  And I should see "oscar's orphanage"
		  And I should see "olivia's orphanage"


	Scenario: Create a new organization
	  Given I go to the organizations page
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


