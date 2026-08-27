Feature: Post to all products list on automationexercise

  @negative @products
  Scenario: Post to all products list
    Given url "https://automationexercise.com" + "/api/productsList"
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 405,
      message: 'This request method is not supported.'
    }
    """