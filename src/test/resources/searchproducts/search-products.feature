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