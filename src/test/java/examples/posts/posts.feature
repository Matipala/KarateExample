Feature: Post API

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer ' + BearerToken
    * def userId = karate.get('userId')

  Scenario: Get Posts
    Given path 'posts'
    When method get
    Then status 200
    And match each response == { id: '#number', user_id: '#number', title: '#string', body: '#string' }

  Scenario: Create Post
    * def postPayload =
      """
      {
        title: '#(postTitle)',
        body: '#(postBody)'
      }
      """
    Given path 'users', userId, 'posts'
    And request postPayload
    When method post
    Then status 201
    And match response ==
      """
      {
        id: '#number',
        user_id: '#(userId)',
        title: '#(postTitle)',
        body: '#(postBody)'
      }
      """
    * def postId = response.id
    * eval karate.set('postId', response.id)
  Scenario: Update Post
    * def updatePostPayload =
      """
      {
        title: '#(postTitle)',
        body: '#(postBody)'
      }
      """
    Given path 'posts', postId
    And request updatePostPayload
    When method patch
    Then status 200
    And match response contains updatePostPayload
    And match response.id == postId

  Scenario: Delete Post
    Given path 'posts', postId
    When method delete
    Then status 204
    And match response == ''
