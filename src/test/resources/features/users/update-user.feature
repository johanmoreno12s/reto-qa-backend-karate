Feature: Actualizar usuarios

  Background:
    * url baseUrl

  Scenario: Actualizar los datos de un usuario existente
    * def user = userData()
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id
    * def updatedUser = userData()
    * set updatedUser.email = user.email

    Given path 'usuarios', userId
    And request updatedUser
    When method put
    Then status 200
    And match response == { message: 'Registro alterado com sucesso' }

    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response.nome == updatedUser.nome
    And match response.email == user.email

    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

  Scenario: Rechazar la actualización con el correo de otro usuario
    * def original = userData()
    Given path 'usuarios'
    And request original
    When method post
    Then status 201
    * def originalId = response._id

    * def other = userData()
    Given path 'usuarios'
    And request other
    When method post
    Then status 201
    * def otherId = response._id
    * set original.email = other.email

    Given path 'usuarios', originalId
    And request original
    When method put
    Then status 400
    And match response == { message: 'Este email já está sendo usado' }

    Given path 'usuarios', originalId
    When method delete
    Then status 200
    Given path 'usuarios', otherId
    When method delete
    Then status 200