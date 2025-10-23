Feature: Comment API

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer ' + BearerToken
    * def postId = karate.get('postId')

  Scenario: Create Comment
    * def commentPayload =
      """
      {
        name: '#(userName)',
        email: '#(userEmail)',
        body: '#(comment)'
      }
      """
    Given path 'posts', postId, 'comments'
    And request commentPayload
    When method post
    Then status 201
    And match response ==
      """
      {
        id: '#number',
        post_id: '#(postId)',
        name: '#(userName)',
        email: '#(userEmail)',
        body: '#(comment)'
      }
      """
    * def commentId = response.id
    * eval karate.set('commentId', response.id)

  Scenario: Get Comments
    Given path 'comments'
    When method get
    Then status 200
    And assert response.length > 0
    And match each response == { id: '#number', post_id: '#number', name: '#string', email: '#string', body: '#string' }

  Scenario: Update Comment
    * def updateCommentPayload = { body: '#(comment)' }
    Given path 'comments', commentId
    And request updateCommentPayload
    When method patch
    Then status 200
    And match response.body == comment
    And match response.id == commentId

  Scenario: Delete Comment
    Given path 'comments', commentId
    When method delete
    Then status 204
    And match response == ''
