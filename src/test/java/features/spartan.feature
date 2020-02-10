@spartan
Feature: practice with spartan app

  Background: Setup
    * url 'http://3.87.83.231:8000'


    Scenario: get all spartans
      And path '/api/spartans'
      When method get
      Then status 200
      * print response


      Scenario: Add new spartan and verify status code 201 and delete it
        Given path '/api/spartans'
        * def spartan =
        """
          {
            "name": "SDET",
            "gender": "Male",
            "phone": 1234536789012
          }
        """
        * request spartan
        When method post
        Then status 201
        * def id = response.data.id
        Given path '/api/spartans/', id
        When method delete
        Then status 204


        Scenario: Delete spartan with id: 152
          Given path '/api/spartans/152'
          When method delete
          Then status 204

        Scenario: Add new Spartan by reading external JSON payload and delete it
          Given path '/api/spartans'
          * def spartan = read('../test_data/payloads/spartan.json')
          * request spartan
          When method post
          Then status 201
          And assert response.success == 'A Spartan is Born!'
          * def id = response.data.id

          Given path '/api/spartans/', id
          When method delete
          Then status 204
