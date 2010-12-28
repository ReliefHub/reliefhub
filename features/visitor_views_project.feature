Feature: Visitor reviews project

  In order to donate to a Haitian orphanage project
  As a visitor
  I want to view the project

  Scenario: Visitor reviews project
    Given the following organization exists:
      | name                          |
      | Mission des Eglises Baptistes |
    And the following project exists:
      | name                | description   | funds purpose           | goal | organization                        |
      | Christmas Toy Drive | Toys for tots | New or gently used toys | 1000 | name: Mission des Eglises Baptistes |
    And "Christmas Toy Drive" has a project photo
    And I am on the homepage
    And I follow "Christmas Toy Drive"
    Then I should be on the "Christmas Toy Drive" project page
    And I should see "Christmas Toy Drive"
    And I should see "Mission des Eglises Baptistes"
    And I should see "Toys for tots"
    And I should see "New or gently used toys"
    And I should see "$1,000"
    And I should see "$0"
    And I should see "0% Raised"
    And I should see the "medium" photo for the "Christmas Toy Drive" project
    And I should see the Facebook and Twitter share buttons
    And I should see a Google map image of "Mission des Eglises Baptistes"'s address
    And I should see "Comments"
