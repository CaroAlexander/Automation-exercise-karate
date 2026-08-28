Feature: Search Products API

  Background:
    * url baseUrl
    * path "/api/searchProduct"

  @smoke @search @API5
  Scenario: Search product successfully
    Given form field search_product = 'Top'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length > 0
    And match each response.products contains
    """
    {
      id: '#number',
      name: '#string',
      price: '#string',
      brand: '#string',
      category: {
        usertype: {
          usertype: '#string'
        },
        category: '#string'
      }
    }
    """

  @negative @search @API6
  Scenario: Search product without search_product parameter
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 400,
      message: 'Bad request, search_product parameter is missing in POST request.'
    }
    """

  @negative @search
  Scenario: Search for a non-existing product
    Given form field search_product = 'NonExistingProduct12345'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length == 0

  @negative @search
  Scenario: Search product with empty search_product parameter
    Given form field search_product = ''
    When method POST
    Then status 200
    And match response.responseCode == 200
    # And match response.message == 'User not found!'

  @negative @search
  Scenario: Search product using special characters
    Given form field search_product = '@#$%^&*'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length == 0

  @regression @search
  Scenario Outline: Search product with different letter cases
    Given form field search_product = '<searchValue>'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length > 0

    Examples:
      | searchValue |
      | top         |
      | Top         |
      | TOP         |

  @regression @search
  Scenario: Verify product search is case insensitive

  # Lowercase search
    Given form field search_product = 'top'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length > 0
    * def lowercaseCount = response.products.length

  # Capitalized search
    Given path "/api/searchProduct"
    And form field search_product = 'Top'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length > 0
    * def capitalizedCount = response.products.length

  # Uppercase search
    Given path "/api/searchProduct"
    And form field search_product = 'TOP'
    When method POST
    Then status 200
    And match response.responseCode == 200
    And match response.products == '#[]'
    And assert response.products.length > 0
    * def uppercaseCount = response.products.length

  # Compare number of results
    And assert lowercaseCount == capitalizedCount
    And assert lowercaseCount == uppercaseCount