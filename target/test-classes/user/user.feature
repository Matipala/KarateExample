Feature: User API

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer ' + BearerToken

  Scenario: Get Users
    Given path 'users'
    When method get
    Then status 200
    And match response == '#[]'
    And match each response == { id: '#number', name: '#string', email: '#string', gender: '#string', status: '#string' }
    And assert response.length > 0   # la lista no debe estar vacía

  Scenario: Create User
    Given path 'users'
    And request { name: userName, gender: userGender, email: userEmail, status: userStatus }
    When method post
    Then status 201
    And match response ==
      """
      {
        id: '#number',
        name: '#(userName)',
        email: '#(userEmail)',
        gender: '#(userGender)',
        status: '#(userStatus)'
      }
      """
    * def userId = response.id

  Scenario: Get User Detail
    Given path 'users', userId
    When method get
    Then status 200
    And match response == { id: '#(userId)', name: '#string', email: '#string', gender: '#string', status: '#string' }
    And match response.id == userId
    And match response.email == userEmail
    And match response.gender == userGender

  Scenario: Update User
    Given path 'users', userId
    And request { name: userName, email: userEmail, status: userStatus }
    When method patch
    Then status 200
    And match response contains { name: userName, email: userEmail, status: userStatus }
    And match response.id == userId

  Scenario: Delete User
    Given path 'users', userId
    When method delete
    Then status 204
    And match response == ''   # el body debe estar vacío
