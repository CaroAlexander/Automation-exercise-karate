Feature: Users API

  Background:
    * url "https://automationexercise.com"
    * def timestamp = java.lang.System.currentTimeMillis()
    * def userEmail = 'qa.automation.' + timestamp + '@test.com'
    * def userPassword = 'Password123'

  @smoke @users @e2e @API11 @API12 @API13 @API14
  Scenario: Create, get, update and delete user account

    # API 11 - Create Account
    Given path "/api/createAccount"
    And form field name = "QA Automation"
    And form field email = userEmail
    And form field password = userPassword
    And form field title = "Mr"
    And form field birth_date = "10"
    And form field birth_month = "5"
    And form field birth_year = "1995"
    And form field firstname = "QA"
    And form field lastname = "Automation"
    And form field company = "Automation Testing"
    And form field address1 = "Test Address"
    And form field address2 = "Test Address 2"
    And form field country = "Colombia"
    And form field zipcode = "110111"
    And form field state = "Cundinamarca"
    And form field city = "Bogota"
    And form field mobile_number = "8142270421"
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 201,
      message: 'User created!'
    }
    """

    # API 14 - Get User Account Detail by Email
    Given path "/api/getUserDetailByEmail"
    And param email = userEmail
    When method GET
    Then status 200
    And match response.responseCode == 200
    And match response.user contains
    """
    {
      name: 'QA Automation',
      email: '#(userEmail)'
    }
    """

    # API 13 - Update Account
    Given path "/api/updateAccount"
    And form field name = "QA Automation Updated"
    And form field email = userEmail
    And form field password = userPassword
    And form field title = "Mr"
    And form field birth_date = "10"
    And form field birth_month = "5"
    And form field birth_year = "1995"
    And form field firstname = "QA"
    And form field lastname = "Automation"
    And form field company = "Automation Testing Updated"
    And form field address1 = "Updated Address"
    And form field address2 = "Updated Address 2"
    And form field country = "Colombia"
    And form field zipcode = "110111"
    And form field state = "Cundinamarca"
    And form field city = "Bogota"
    And form field mobile_number = "8142270422"
    When method PUT
    Then status 200
    And match response ==
    """
    {
      responseCode: 200,
      message: 'User updated!'
    }
    """

    # Verify updated user
    Given path "/api/getUserDetailByEmail"
    And param email = userEmail
    When method GET
    Then status 200
    And match response.responseCode == 200
    And match response.user contains
    """
    {
      name: 'QA Automation Updated',
      email: '#(userEmail)'
    }
    """

    # API 12 - Delete Account
    Given path "/api/deleteAccount"
    And form field email = userEmail
    And form field password = userPassword
    When method DELETE
    Then status 200
    And match response ==
    """
    {
      responseCode: 200,
      message: 'Account deleted!'
    }
    """