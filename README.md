# Pruebas de API de usuarios con Karate

Suite de automatización para las operaciones CRUD de usuarios de [ServeRest](https://serverest.dev/), implementada con Karate DSL, JUnit 5 y Maven.

Repositorio: [johanmoreno12s/reto-qa-backend-karate](https://github.com/johanmoreno12s/reto-qa-backend-karate).

## Requisitos

- Java 17 o superior
- Maven 3.8 o superior
- Conexión a internet para usar `https://serverest.dev`

## Ejecutar

Desde la raíz del proyecto:

```bash
mvn test
```

Para apuntar a una instancia local o a otro ambiente:

```bash
mvn test -DbaseUrl=http://localhost:3000
```

Los reportes HTML se generan en `target/karate-reports/karate-summary.html`.

## Cobertura

Los archivos de `src/test/resources/features/users/` cubren `GET /usuarios`, `POST /usuarios`, `GET /usuarios/{_id}`, `PUT /usuarios/{_id}` y `DELETE /usuarios/{_id}`. Incluyen verificaciones de esquemas, búsqueda y eliminación de IDs inexistentes, y rechazo de correos duplicados.

Los usuarios creados durante los escenarios usan email y nombre únicos, y se eliminan al terminar el flujo. La API pública es compartida y externa; por ello, la ejecución requiere conectividad y puede estar sujeta a disponibilidad o limitaciones del servicio.

## Estrategia de automatización

La suite prioriza escenarios independientes y repetibles: cada operación crea sus propios datos cuando los necesita, verifica código HTTP, contenido y estructura JSON, y limpia los registros creados. Un generador común basado en UUID evita colisiones entre ejecuciones. La configuración centralizada permite cambiar la URL base sin editar los features. El informe de patrones está en [`docs/estrategia.md`](docs/estrategia.md).

