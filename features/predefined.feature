@predefined
Feature: Predefined steps

  @predefined1
  Scenario: Cucumber embedded steps for Google
    Given I navigate to "https://google.com"
    Then I should see page title as "Google"
    When I enter "Behavior Driven Development framework" into input field having xpath "//input[@name='q']"
    And I wait for 1 sec
    And I click on element having xpath "//*[@value='Google Search']"
    And I wait 5 seconds for element having xpath "//*[@id='ires']" to display
    Then element having xpath "//*[@id='ires']" should have partial text as "Cucumber"

  @predefined2
  Scenario: Cucumber embedded steps for Yahoo
    Given I navigate to "https://www.yahoo.com/"
    Then I should see page title as "Yahoo"
    When I enter "Behavior Driven Development framework" into input field having xpath "//input[@id='uh-search-box']"
    And I wait for 1 sec
    And I click on element having xpath "//button[@id='uh-search-button']"
    And I wait 5 seconds for element having xpath "//div[@id='results']" to display
    Then element having xpath "//div[@id='results']" should have partial text as "Cucumber"