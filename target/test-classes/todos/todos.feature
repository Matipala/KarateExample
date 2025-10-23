Feature: Todo API

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer ' + BearerToken
    * def userId = karate.get('userId')

  Scenario: Create Todo
    Given path 'users', userId, 'todos'
    And request { title: todoTitle, status: todoStatus, due_on: todoDueOn }
    When method post
    Then status 201
    And match response ==
      """
      {
        id: '#number',
        user_id: '#(userId)',
        title: '#(todoTitle)',
        status: '#(todoStatus)',
        due_on: '#string'
      }
      """
    * def todoId = response.id

  Scenario: Get Todos
    Given path 'todos'
    When method get
    Then status 200
    And assert response.length > 0
    And match each response == { id: '#number', user_id: '#number', title: '#string', due_on: '#string', status: '#string' }

  Scenario: Update Todo
    Given path 'todos', todoId
    And request { title: todoTitle, status: todoStatus }
    When method patch
    Then status 200
    And match response.title == todoTitle
    And match response.status == todoStatus
    And match response.id == todoId

  Scenario: Delete Todo
    Given path 'todos', todoId
    When method delete
    Then status 204
    And match response == ''
