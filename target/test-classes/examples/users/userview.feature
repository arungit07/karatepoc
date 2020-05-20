Feature: To check the user view functionality
   # This feature file deals with user-view scenarios

  Background:

    * url myurl
    * def accessToken = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
  @positive @view-user
  Scenario: Checking whether possible to view a user
    * def result = call read('usersnew.feature')

    Given  path  'users/' + result.id
    And  header Authorization = 'Bearer ' + accessToken

    When  method get
    Then status 200
    And match response._meta.message contains 'OK. Everything worked as expected.'

    * karate.log(response)