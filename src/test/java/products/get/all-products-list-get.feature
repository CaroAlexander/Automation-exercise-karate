Feature: Get all products list on automationexerise

  @smoke @products
  Scenario: Get all products
    Given url "https://automationexercise.com" + "/api/productsList"
    When method get
    Then status 200