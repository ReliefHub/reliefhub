Feature: Sign up

  In order to get access to protected sections of the site
  As a user
  I should be able to sign up

	Background:
		Given a project exists

  Scenario: User signs up with invalid data
    When I go to the sign up page
    And I fill in "Email" with "invalidemail"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with ""
    And I press "Sign up"
    Then I should see error messages on the page

  Scenario: User signs up with valid data and confirms
    When I go to the sign up page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up"

