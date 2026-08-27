Feature: Brands API

  Background:
    * url "https://automationexercise.com"
    * path "/api/brandsList"

    @smoke @brands
      Scenario: Get all brands list
      When method GET
      Then status 200
      And match response.responseCode == 200
      And match response.brands == '#[]'
      And assert response.brands.length > 0
      And match each response.brands contains
      """
      {
        id: '#number',
        brand: '#string'
      }
      """
      * def ids = karate.map(response.brands, x => x.id)
      * def uniqueIds = karate.distinct(ids)
      * assert uniqueIds.length == ids.length

  @negative @brands
  Scenario: PUT method is not supported for brands list
    When method PUT
    Then status 200
    And match response ==
    """
    {
      responseCode: 405,
      message: 'This request method is not supported.'
    }
    """