Feature: Verify Login API

  Background:
    * url "https://automationexercise.com"
    * path "/api/verifyLogin"

  @smoke @auth
  Scenario: Verify login with valid credentials
    Given form field email = 'VALID_EMAIL'
    And form field password = 'VALID_PASSWORD'
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 200,
      message: 'User exists!'
    }
    """

  @negative @auth
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

  @negative @auth
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

  @negative @auth
  Scenario: Verify login with invalid credentials
    Given form field email = 'invaliduser@test.com'
    And form field password = 'invalidPassword123'
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 404,
      message: 'User not found!'
    }
    """