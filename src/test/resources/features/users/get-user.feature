Feature: Buscar usuario por ID

  Background:
    * url baseUrl

  Scenario: Obtener un usuario existente
    * def user = userData()
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    And match response._id == '#string'
    * def userId = response._id

    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response == { nome: '#string', email: '#string', password: '#string', administrador: '#? _ == "true" || _ == "false"', _id: '#string' }
    And match response._id == userId
    And match response.nome == user.nome
    And match response.email == user.email

    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

  Scenario: Informar error al buscar un ID inexistente
    Given path 'usuarios', 'AAAAAAAAAAAAAAAA'
    When method get
    Then status 400
    And match response == { message: 'Usuário não encontrado' }