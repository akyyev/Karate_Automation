@bookit
Feature: bookit
#Syntax
#  Use spaces between key = value
#  Case sensitive and space sensitive
#  Query parameters syntax: param key = 'value'
#  Path parameters syntax: path 'value'
#  def keyword is for generic data-type

  Background:
    * url 'https://cybertek-reservation-api-qa.herokuapp.com'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * path 'sign'
    * param email = 'teacherva5@gmail.com'
    * param password = 'maxpayne'
    * method get
    * def token = response.accessToken
    * print "Token: ", token

  Scenario: Verify status code 401 when accessing all rooms without valid authentication token (fails, because it returns 422)
    Given path '/api/rooms'
    When method get
    Then status 401
    
#   /sign?email=teacherva5@gmail.com&password=maxpayne
  Scenario: Sign in
    Given path 'sign'
    * param email = 'teacherva5@gmail.com'
    * param password = 'maxpayne'
    When method get
    Then status 200
#      To store the token
    * def token = response.accessToken
    Then print "Token: ", token


  Scenario: print Token
#        Will print null, in order to read it from another scenarios put steps on background
    And print token


  Scenario: Get all rooms with valid token
    Given path '/api/rooms'
    * header Authorization = token
    When method get
    And print response


  @add_new_student
  Scenario: Add new student
    Given path '/api/students/student'
    * header Authorization = token
    * params {first-name:'Paul', last-name:'George', email:'pgeorge2@email.com', password:'1111', role:'student-team-member', campus-location:'VA', batch-number: 12, team-name:'Online_Hackers'}
    * request 'test'
    When method post
    Then status 201
    And print response


#    Data Driven Testing example, it allows to run same test with different information sets
  Scenario Outline: Verify that <room_name> has id <id>
    Given path '/api/rooms/<room_name>'
    * header Authorization = token
    When method get
    Then match response contains {id: <id>}

    Examples: rooms info
      | id  | room_name |
      | 112 | harvard   |
      | 113 | yale      |
      | 114 | princeton |


