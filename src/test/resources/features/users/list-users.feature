Feature: Listar usuarios

  Background:
    * url baseUrl
    * def userSchema = { nome: '#string', email: '#string', password: '#string', administrador: '#? _ == "true" || _ == "false"', _id: '#string' }

  Scenario: Listar usuarios y validar el esquema de la respuesta
    Given path 'usuarios'
    When method get
    Then status 200
    And match response == { quantidade: '#number', usuarios: '#[]' }
    And match each response.usuarios contains userSchema