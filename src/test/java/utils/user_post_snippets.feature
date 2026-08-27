@ignore
Feature: Reusable scenarios for post a user

  @CreateUser
  Scenario:
    * def DataGenerator = Java.type('data.DataGenerator')
    * def userEmail = DataGenerator.generateEmail()
    * def userPassword = 'Password123'
    * def user =
  """
  {
    name: 'QA Automation',
    email: '#(userEmail)',
    password: '#(userPassword)',
    title: 'Mr',
    birth_date: '12',
    birth_month: '3',
    birth_year: '1996',
    firstname: 'QA',
    lastname: 'Automation',
    company: 'Automation Testing',
    address1: 'Test Address',
    address2: 'Test Address 2',
    country: 'Colombia',
    zipcode: '110111',
    state: 'Cundinamarca',
    city: 'Bogota',
    mobile_number: '8142270421'
  }
  """
    Given url "https://automationexercise.com/api/createAccount"
    And form fields user
    When method POST
    Then status 200
    And match response ==
    """
    {
      responseCode: 201,
      message: 'User created!'
    }
    """