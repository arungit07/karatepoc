Feature: To check the users listing feature of the user API in gorest
  # This feature file deals with various user listing scenarios

  Background:

    * def accessToken = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
    * url myurl

  @positive @user-list-pagewise
 Scenario Outline: Checking users are properly listed on every or particular page
# Check every user listing pages, It should show 20 users records on every page except the last page
    Given path 'users/' + 'index.html'
    And def currentpage = '<page>'
    And  header Authorization = 'Bearer ' + accessToken
    And param page = currentpage
    When method get
    Then status 200

    * def size = function(o){ return o.size()}
    * def length = size(response.result)

    * def pageCheck =
  """
  function(l)
  {
   var pagecount =  response._meta.pageCount;

  // karate.log(pagecount);
   var last = "";

   if( pagecount > currentpage )
    {

       karate.match( l, 20);
       if(currentpage == '0')
       {

//karate.log(currentpage);
       last = "The given page" + currentpage + " is not available, so listing the first page number";

       }

      last = "The given page " + currentpage + " is a valid page";
    }

    if( pagecount < currentpage )
    {

       karate.match( l, '#?_>=1 && _<=20');
      last = "The given page" + currentpage + " is not available, so listing the last page number  : " + pagecount;
    }

   else if (pagecount == currentpage)
   {

    karate.match( l, '#?_>=1 && _< 20');
    last = "This is the last page and the page number is : " + currentpage;

   }
    return last

  }

  """


    * def message = call pageCheck length
    * print message
    * print 'Total No of user records in ', response._meta.currentPage, 'page is ' , length
  #And match length contains '#(test)'? '#?_>=1 && _< 20' : '20'

  #And match length contains '#?_>=1 && _< 20'
  #And match length == 20

 #And match response._meta contains { totalCount: '#? _>=1'}

  Examples:
    | page |
    | 110  |
    | 109 |
    | 15  |
    | 1  |
    | 0  |



  @available-particular-user
  Scenario Outline: Searching for a particular user who is available using first name
# check whether user is searchable using first name, system should list respective users if the searched pattern
    # is available in first name and must consider case insensitive


    Given path 'users'
    And  header Authorization = 'Bearer ' + accessToken
  #And param access-token = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
    And param first_name = '<name>'
    When method get
    Then status 200

    * def size = function(o){ return o.size()}
    * def length = size(response.result)
    And match length contains '#?_>=1'
#   And match each response.result contains { first_name: '#regex ^.*(\mark\b)?.*$'}
    And match response.result[*].first_name contains '#regex ^.*(\mark\b)?.*$'
   # And print response.result[0].first_name

    * def fun =
    """
     function(x)
     {
        karate.log(x.first_name)

     }

     """
    * karate.forEach(response.result , fun)
#And match response._meta contains { totalCount: 1}
  #And match response._meta.totalCount == 1

  Examples:
    | name |
    | MARK |
    | mark |
    | MaRk |


 @negative @not-available-particular-userlist
  Scenario: Checking for a particular user who is not available
#check system is not listing any records for a user who is not available in the data base"


    Given path 'users'
    And  header Authorization = 'Bearer ' + accessToken
  #And param access-token = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
    * def name = 'Geovany'
    And param first_name = '#(name)'
    When method get
    Then status 200

    * def size = function(o){ return o.size()}
    * def length = size(response.result)
    And match length contains '#?_==0'
  And print 'No users are available for the search with ' + name
#    And match each response.result contains { id: '#? _<1000 && _ >500'}
#    And print response.result[0].first_name
#    And match response._meta contains { totalCount: 0}
#    And match response._meta.totalCount == 0
#    And print response._meta.totalCount
#    And match response._meta.message contains 'OK. Everything worked as expected'

