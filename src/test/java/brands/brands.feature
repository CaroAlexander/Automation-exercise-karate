Feature: Brands API

  Background:
    * url "https://automationexercise.com"
    * path "/api/brandsList"

    @smoke @brands
      Scenario: Get all brands list
      Given method get
      Then status 200