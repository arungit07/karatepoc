Feature: To check the user update functionality
   # This feature file deals with update scenarios

  Background:

    * url myurl
    * def accessToken = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
  @positive @updateuser
  Scenario: Checking whether possible to update a user changing gender
    * def result = call read('usersnew.feature')

    Given  path  'users/' + result.id
    And  header Authorization = 'Bearer ' + accessToken
    And request { gender: 'female' }

    When  method put
    Then status 200
    And match response._meta.message contains 'OK. Everything worked as expected.'

    * karate.log(response)