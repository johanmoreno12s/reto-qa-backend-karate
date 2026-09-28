# Estrategia de automatización

## Alcance

Se prueban los cinco endpoints CRUD de usuarios de ServeRest. Para cada operación se valida el estado HTTP y el cuerpo JSON; las respuestas principales se contrastan con esquemas Karate para detectar cambios de estructura o tipo.

## Patrones utilizados

- **Features por recurso/operación:** cada archivo representa un endpoint y su comportamiento, haciendo que los fallos sean fáciles de localizar.
- **Datos únicos por ejecución:** `userData()` agrega un UUID al nombre y al correo para impedir colisiones con datos existentes o ejecuciones concurrentes.
- **Arrange, act, assert y cleanup:** los flujos CRUD preparan los datos necesarios, ejecutan la petición, validan el resultado y eliminan los usuarios creados.
- **Escenarios negativos contractuales:** se cubren ID inexistente, correo duplicado y eliminación de un registro ausente según las respuestas documentadas por la API.
- **Configuración externalizada:** `baseUrl` se puede sobreescribir con una propiedad Maven; headers y timeouts se definen una sola vez.

## Ejecución y límites

`mvn test` corre la suite con Java 17 y Maven. Los tests apuntan por defecto a `https://serverest.dev`, un servicio público compartido; se recomienda una instancia local para ejecuciones de CI estables. La limpieza es explícita al final de cada flujo exitoso y no puede garantizarse si la API deja de responder a mitad de un escenario.