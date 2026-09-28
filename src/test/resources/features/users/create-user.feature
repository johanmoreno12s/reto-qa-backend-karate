Feature: Registrar usuarios

  Background:
    * url baseUrl

  Scenario: Registrar un usuario válido y confirmar sus datos
    * def user = userData()
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def userId = response._id

    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response == { nome: '#string', email: '#string', password: '#string', administrador: 'false', _id: '#string' }
    And match response._id == userId
    And match response.nome == user.nome
    And match response.email == user.email

    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

  Scenario: Rechazar un correo ya registrado
    * def user = userData()
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def userId = response._id

    Given path 'usuarios'
    And request user
    When method post
    Then status 400
    And match response == { message: 'Este email já está sendo usado' }

    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'