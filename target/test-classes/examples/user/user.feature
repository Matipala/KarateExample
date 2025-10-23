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
    And assert response.length > 0

  Scenario: Create User
    * print '>>> userEmail:', userEmail
    * print '>>> userGender:', userGender
    * print '>>> userStatus:', userStatus

    Given path 'users'
    And request
      """
      {
        name: '#(userName)',
        gender: '#(userGender)',
        email: '#(userEmail)',
        status: '#(userStatus)'
      }
      """
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
    * eval karate.set('userId', response.id)
    * print '>>> userId set globally =', userId

  Scenario: Get User Detail
    Given path 'users', userId
    When method get
    Then status 200
    And match response.id == userId
    And match response.email == userEmail
    And match response.gender == userGender

  Scenario: Update User
    * def updatePayload =
      """
      {
        name: '#(userName)',
        email: '#(userEmail)',
        status: '#(userStatus)'
      }
      """
    Given path 'users', userId
    And request updatePayload
    When method patch
    Then status 200
    And match response contains updatePayload
    And match response.id == userId

  Scenario: Delete User
    Given path 'users', userId
    When method delete
    Then status 204
    And match response == ''
