Feature: Users API

  Background:
    * url baseUrl

  @smoke @users @e2e @API11 @API12 @API13 @API14
  Scenario: Create, get, update and delete user account

    # API 11 - Create Account
    * call read("../utils/user_account_snippets.feature@CreateUser")

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
    * def updateData = read('classpath:utils/user_update_data.json')
    * copy updatedUser = user
    * set updatedUser.name = updateData.name
    * set updatedUser.company = updateData.company
    * set updatedUser.address1 = updateData.address1
    * set updatedUser.address2 = updateData.address2
    * set updatedUser.mobile_number = updateData.mobile_number

    Given path '/api/updateAccount'
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
    Given path '/api/getUserDetailByEmail'
    And param email = userEmail
    When method GET
    Then status 200
    And match response.responseCode == 200
    And match response.user contains
"""
{
  name: '#(updateData.name)',
  email: '#(userEmail)',
  company: '#(updateData.company)',
  address1: '#(updateData.address1)'
}
"""

    # API 12 - Delete Account
    * call read('classpath:utils/user_post_snippets.feature@DeleteUser')

    # Verify deleted user cannot login
    Given path '/api/verifyLogin'
    And form field email = userEmail
    And form field password = userPassword
    When method POST
    Then status 200
    And match response ==
"""
{
  responseCode: 404,
  message: 'User not found!'
}
"""