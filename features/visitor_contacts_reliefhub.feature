Feature: Contact us

  In order to provide feedback
  As a donor
  I want to contact ReliefHub

  Scenario: Visitor contacts us
    Given I go to the "about us" static page
    And I fill in "Email" with "barry@example.com"
    And I fill in "Body" with "You guys rock"
    And I press "Contact us"
    Then I should see "Thanks for contacting us."
    And "info@reliefhub.org" should receive an email
    When "info@reliefhub.org" opens the email with subject "Contact us"
    Then they should see "You guys rock" in the email body

  Scenario: Visitor tries to contact us without an email from
    Given I go to the "about us" static page
    And I fill in "Body" with "Howdy"
    And I press "Contact us"
    Then I should see "Email was not sent. Please enter your email address."

  @wip
  Scenario: Donor contacts us
    Given I have signed in with "joe@example.com/password"
    And I go to the "about us" static page
    And I fill in "Body" with "You guys rock"
    And I press "Contact us"
    Then I should see "Thanks for contacting us."
    And "info@reliefhub.org" should receive an email
    When "info@reliefhub.org" opens the email with subject "Contact us"
    Then they should see "You guys rock" in the email body

  @wip
  Scenario: Donor tries to contact us without an email body
    Given I have signed in with "joe@example.com/password"
    And I go to the "about us" static page
    And I fill in "Body" with ""
    And I press "Contact us"
    Then I should see "Email was not sent. Please enter some text."
