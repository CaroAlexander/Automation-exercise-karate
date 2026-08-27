Feature: Verify Login API

  Background:
    * url "https://automationexercise.com"
    * path "/api/verifyLogin"

  @smoke @auth @API7
  Scenario: Verify login with valid credentials
    Given form field email = 'alex.qa.test@example.com'
    And form field password = 'Password123'
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 200,
      message: 'User exists!'
    }
    """

  @negative @auth @API8
  Scenario: Verify login without email parameter
    Given form field password = 'VALID_PASSWORD'
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 400,
      message: 'Bad request, email or password parameter is missing in POST request.'
    }
    """

  @negative @auth @API8
  Scenario Outline: Verify login with missing parameters
    * def credentials = <credentials>

    Given form fields credentials
    When method POST
    Then status 200
    And match response.responseCode == 400
    And match response.message == 'Bad request, email or password parameter is missing in POST request.'

    Examples:
      | credentials                   |
      | { password: 'Password123' }   |
      | { email: 'invalid@test.com' } |
      | {}                            |

  @negative @auth @API9
  Scenario: DELETE method is not supported for verify login
    When method DELETE
    Then status 200
    And match response ==
    """
    {
      responseCode: 405,
      message: 'This request method is not supported.'
    }
    """

  @negative @auth @API10
  Scenario Outline: Verify login with invalid credentials

    Given form field email = '<email>'
    And form field password = '<password>'
    When method POST
    Then status 200
    And match response.responseCode == 404
    And match response.message == 'User not found!'

    Examples:
      | email                  | password          |
      | invalid@test.com       | Password123       |
      | nonexistent@test.com   | WrongPassword     |
      | qa.invalid@test.com    | InvalidPassword   |