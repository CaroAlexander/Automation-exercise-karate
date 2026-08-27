Feature: Post to all products list on automationexercise

  Background:
    * url baseUrl
    * path "/api/productsList"

  @negative @products @API2
  Scenario: Post to all products list
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 405,
      message: 'This request method is not supported.'
    }
    """