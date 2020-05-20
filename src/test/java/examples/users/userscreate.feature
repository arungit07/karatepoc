Feature: To check the user creation functionality
# This feature file deals with various user creation scenarios
  Background:

    * url myurl
    * def accessToken = 'SgAL3dv2sLpkUMR_MSKFvn2RkViDLx12MxMN'
@positive @mandatory-only
  Scenario: Checking whether possible to create a new user with mandatory fields like first,last name ,gender and email

    Given  path  'users/' + 'create.html'
    And  header Authorization = 'Bearer ' + accessToken
    And request
  """
  { first_name: 'nany1',
    last_name: 'jacob',
    gender:'male',
    email:'cv2@c.com'}
  """
    When  method post
    Then status 200
      And match response._meta.message contains 'OK. Everything worked as expected.'

    * karate.log(response)
@positive @Fill-alldata
    Scenario: Checking with possible to create a new user will available data

      Given  path  'users/' + 'create.html'
      And  header Authorization = 'Bearer ' + accessToken
      And request
  """
  { first_name: 'nany2',
    last_name: 'jacob',
    gender:'male',
    email:'cv4@c.com',
    dob: '1990-11-05',
    phone: '2312345678',
    status:'active',
    address: ' hello,mTVM',
    website: 'http://ebert.com/consequatur-dolor-repellendus-provident-magni-molestiae-facere-fuga-voluptatem',
    about: 'Heelo hai'}
  """
      When  method post
      Then status 200
  * karate.log(response)
      And match response._meta.message contains 'OK. Everything worked as expected.'

  @negative @Fill-withoutdata
  Scenario: Checking to create a new user with no data over mandatory fields

    Given  path  'users/' + 'create.html'
    And  header Authorization = 'Bearer ' + accessToken
    And request
  """
  { first_name: '',
    last_name: '',
    gender:'',
    email:'',
    dob: '',
    phone: '',
    status:'',
    address: '',
    website: '',
    about: ''}
  """
    When  method post
    Then status 200
    * karate.log(response)
    And match response._meta.message contains 'Data validation failed. Please check the response body for detailed error messages.'
    And match response.result[*] contains {field:'email',message:'Email cannot be blank.'}
    And match response.result[*] contains {field:'first_name', message:'First Name cannot be blank.'}
    And match response.result[*] contains {field:'last_name', message:'Last Name cannot be blank.'}
    And match response.result[*] contains {field:'gender', message:'Gender cannot be blank.'}



  @negative @mandatoryfields-with-blankdata
  Scenario: Checking to create a new user with blank data on mandatory fields

    Given  path  'users/' + 'create.html'
    And  header Authorization = 'Bearer ' + accessToken
    And request
  """
  { first_name: '  ',
    last_name: '  ',
    gender:'  ',
    email:'  ',
    dob: '  ',
    phone: '  ',
    status:'  ',
    address: '  ',
    website: '  ',
    about: '  '}
  """
    When  method post
    Then status 200
    * karate.log(response)
    And match response._meta.message contains 'Data validation failed. Please check the response body for detailed error messages.'
    And match response.result[*] contains {field:'email',message:'Email cannot be blank.'}
    And match response.result[*] contains {field:'first_name', message:'First Name cannot be blank.'}
    And match response.result[*] contains {field:'last_name', message:'Last Name cannot be blank.'}
    And match response.result[*] contains {field:'gender', message:'Gender cannot be blank.'}

  @negative @with-invalid-status
  Scenario Outline: Checking to create a new user  with invalid status

    Given  path  'users/' + 'create.html'
    And  header Authorization = 'Bearer ' + accessToken
    And def value = <statusvalue>
    And request
  """
  { first_name: 'nuby5',
    last_name: 'jacob',
    gender:'male',
    email:'cv6@c.com',
    dob: '1990-11-05',
    phone: '1234567890',
    status:'#(value)',
    address: 'Test',
    website: 'http://ebert.com/consequatur-dolor-repellendus-provident-magni-molestiae-facere-fuga-voluptatem',
    about: 'test'}
  """
    When  method post
    Then status 200
    * karate.log(response)
    And match response._meta.message contains 'Data validation failed. Please check the response body for detailed error messages.'
    And match response.result[*] contains {field:'status',message:'Status is invalid.'}

    Examples:
    | statusvalue |
    |'test'     |
    | '  '      |

  @negative @with-invalid-website
  Scenario Outline: Checking to create a new user  with invalid website

    Given  path  'users/' + 'create.html'
    And  header Authorization = 'Bearer ' + accessToken
    And def value = <websitevalue>
    And request
  """
  { first_name: 'nuby5',
    last_name: 'jacob',
    gender:'male',
    email:'cv6@c.com',
    dob: '1990-11-05',
    phone: '1234567890',
    status:'',
    address: 'Test',
    website: '#(value)',
    about: 'test'}
  """
    When  method post
    Then status 200
    * karate.log(response)
    And match response._meta.message contains 'Data validation failed. Please check the response body for detailed error messages.'
    And match response.result[*] contains {field:'website',message:'Website is not a valid URL.'}

    Examples:
      | websitevalue |
      |'test'     |
      | '  '      |

  @negative @with-invalid-dob
  Scenario Outline: Checking to create a new user  with invalid status

    Given  path  'users/' + 'create.html'
    And  header Authorization = 'Bearer ' + accessToken
    And def value = <dobvalue>
    And request
  """
  { first_name: 'nuby5',
    last_name: 'jacob',
    gender:'male',
    email:'cv6@c.com',
    dob: '#(value)',
    phone: '1234567890',
    status:'',
    address: 'Test',
    website: '',
    about: 'test'}
  """
    When  method post
    Then status 200
    * karate.log(response)
    And match response._meta.message contains 'Data validation failed. Please check the response body for detailed error messages.'
    And match response.result[*] contains {field:'dob',message:'user must have atleast 11 years to have an account'}

    Examples:
      | dobvalue |
      |'test'     |
      | '  '      |
      | '11111111' |
      |  '2020-11-05'  |
