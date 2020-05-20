Feature: To check the user delete functionality
   # This feature file deals with delete scenarios

  Background:

    * url myurl
    * def accessToken = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
  @positive @delete-user
  Scenario: Checking whether possible to delete a user

    * def result = call read('usersnew.feature')

    Given  path  'users/' + result.id
    And  header Authorization = 'Bearer ' + accessToken
    When  method delete
    Then status 200
   # And match response._meta.message contains 'OK. Everything worked as expected.'

    * karate.log(response)