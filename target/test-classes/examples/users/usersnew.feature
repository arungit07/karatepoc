Feature: To check the user creation functionality
    # The feature file is called by user-update and user-delete feature file( To support calling of feature file)
  Background:

    * url myurl
    * def accessToken = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'

  Scenario: Checking whether possible to create a new user with mandatory fields like first,last name ,gender and email


   Given  path  'users/' + 'create.html'
     And  header Authorization = 'Bearer ' + accessToken
    And request
  """
  { first_name: 'nany1',
    last_name: 'jacob',
    gender:'male',
    email:'cv1@c.com'}
  """
    When  method post
    Then status 200
    And match response._meta.message contains 'OK. Everything worked as expected.'

    * def id = response.result.id
    * print ' The user id :\n' + id

    * karate.log(response)