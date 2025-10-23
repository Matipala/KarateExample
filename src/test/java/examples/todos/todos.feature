Feature: Todo API

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer ' + BearerToken
    * def userId = karate.get('userId')

  Scenario: Create Todo
    * def todoPayload =
      """
      {
        title: '#(todoTitle)',
        status: '#(todoStatus)',
        due_on: '#(todoDueOn)'
      }
      """
    Given path 'users', userId, 'todos'
    And request todoPayload
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
    * eval karate.set('todoId', response.id)

  Scenario: Get Todos
    Given path 'todos'
    When method get
    Then status 200
    And assert response.length > 0
    And match each response == { id: '#number', user_id: '#number', title: '#string', due_on: '#string', status: '#string' }

  Scenario: Update Todo
    * def updateTodoPayload =
      """
      {
        title: '#(todoTitle)',
        status: '#(todoStatus)'
      }
      """
    Given path 'todos', todoId
    And request updateTodoPayload
    When method patch
    Then status 200
    And match response contains updateTodoPayload
    And match response.id == todoId

  Scenario: Delete Todo
    Given path 'todos', todoId
    When method delete
    Then status 204
    And match response == ''
