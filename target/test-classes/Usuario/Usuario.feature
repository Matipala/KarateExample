Feature: Usuarios
   Background:
     * url 'https://gorest.co.in/public/v2'
     * header Accept = 'application/json'
     * header Content-Type = 'application/json'
     * header Authorization = 'Bearer e582c281c7b7462e01a3a05be8f93aaa4b40dda654ceb0126ba3f538b43da610'
     * def req_header = {Authorization: 'Bearer e582c281c7b7462e01a3a05be8f93aaa4b40dda654ceb0126ba3f538b43da610'}

     * def dataGeneration = Java.type('Utils.DataGenerator')
     * def payload =
     """
     {
        "gender": "male",
        "status": "active"
     }
     """
     * payload.name = dataGenerator.gerUserRandom().name
     * payload.email = dataGenerator.getUserRandom().email

     @Post
  Scenario: Crear un nuevo usuario
    Given path 'users'
    And request
    """
    {
      "name": "Usuario",
      "gender": "male",
      "email": "test@test1",
      "status": "active"
    }
    """
    When method post
    Then status 201
    And match response ==
    """
    {
      "id": "#number",
      "name": "Usuario",
      "email": "test@test1",
      "gender": "male",
      "status": "active"
    }
    """