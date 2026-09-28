Feature: Eliminar usuarios

  Background:
    * url baseUrl

  Scenario: Eliminar un usuario existente y comprobar que ya no está disponible
    * def user = userData()
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id

    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response == { message: 'Registro excluído com sucesso' }

    Given path 'usuarios', userId
    When method get
    Then status 400
    And match response == { message: 'Usuário não encontrado' }

  Scenario: Eliminar un ID inexistente sin afectar otros usuarios
    Given path 'usuarios', 'AAAAAAAAAAAAAAAA'
    When method delete
    Then status 200
    And match response == { message: 'Nenhum registro excluído' }