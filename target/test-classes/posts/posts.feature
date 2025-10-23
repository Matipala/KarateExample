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
    Given path 'users', userId, 'posts'
    And request { title: postTitle, body: postBody }
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

  Scenario: Update Post
    Given path 'posts', postId
    And request { title: postTitle, body: postBody }
    When method patch
    Then status 200
    And match response.title == postTitle
    And match response.body == postBody

  Scenario: Delete Post
    Given path 'posts', postId
    When method delete
    Then status 204
    And match response == ''
