Feature: Get all products list on automationexercise

  @smoke @products @API1
  Scenario: Get all products
    Given url "https://automationexercise.com" + "/api/productsList"
    When method get
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
    * def ids = karate.map(response.products, x => x.id)
    * def uniqueIds = karate.distinct(ids)
    * assert uniqueIds.length == ids.length