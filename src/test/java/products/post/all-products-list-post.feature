Feature: Post to all products list on automationexerise

  @smoke @products
  Scenario: Post to all products list
    Given url "https://automationexercise.com" + "/api/productsList"
    When method post
    Then status 200
    And match response.responseCode == 405