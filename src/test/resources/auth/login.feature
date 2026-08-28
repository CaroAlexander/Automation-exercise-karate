Feature: Verify Login API

  Background:
    * url baseUrl

  @smoke @auth @API7
  Scenario: Verify login with valid credentials
    * def createdUser = call read('../utils/user_account_snippets.feature@CreateUser')
    * def userEmail = createdUser.userEmail
    * def userPassword = createdUser.userPassword

  # Verify login
    Given path '/api/verifyLogin'
    And form field email = userEmail
    And form field password = userPassword
    When method POST
    Then status 200
    And match response ==
  """
  {
    responseCode: 200,
    message: 'User exists!'
  }
  """

    * call read('../utils/user_account_snippets.feature@DeleteUser') { userEmail: '#(userEmail)', userPassword: '#(userPassword)' }


  @negative @auth @API8
  Scenario: Verify login without email parameter
    Given path '/api/verifyLogin'
    And form field password = 'VALID_PASSWORD'
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
    Given path '/api/verifyLogin'
    And form fields credentials
    When method POST
    Then status 200
    And match response.responseCode == 400
    And match response.message == 'Bad request, email or password parameter is missing in POST request.'

    Examples:
      | credentials                   |
      | { password: defaultPassword } |
      | { email: 'invalid@test.com' } |
      | {}                            |

  @negative @auth @API9
  Scenario: DELETE method is not supported for verify login
    Given path '/api/verifyLogin'
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
    Given path '/api/verifyLogin'
    And form field email = '<email>'
    And form field password = <password>
    When method POST
    Then status 200
    And match response.responseCode == 404
    And match response.message == 'User not found!'

    Examples:
      | email                | password          |
      | invalid@test.com     | defaultPassword   |
      | nonexistent@test.com | 'WrongPassword'   |
      | qa.invalid@test.com  | 'InvalidPassword' |