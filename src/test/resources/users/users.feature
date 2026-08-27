Feature: Users API

  Background:
    * url baseUrl

  @smoke @users @e2e @API11 @API12 @API13 @API14
  Scenario: Create, get, update and delete user account

    # API 11 - Create Account
    * call read("../utils/user_post_snippets.feature@CreateUser")

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
    * copy updatedUser = user
    * set updatedUser.name = 'QA Automation Updated'
    * set updatedUser.company = 'Automation Testing Updated'
    * set updatedUser.address1 = 'Updated Address'
    * set updatedUser.address2 = 'Updated Address 2'
    * set updatedUser.mobile_number = '8142270422'

    Given path "/api/updateAccount"
    And form fields updatedUser
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
    And match response.user.company == 'Automation Testing Updated'
    And match $.user.address1 == 'Updated Address'
    And match response.user.mobile_number == '#notpresent'


    # API 12 - Delete Account
    Given path "/api/deleteAccount"
    And form field email = userEmail
    And form field password = defaultPassword
    When method DELETE
    Then status 200
    And match response ==
    """
    {
      responseCode: 200,
      message: 'Account deleted!'
    }
    """