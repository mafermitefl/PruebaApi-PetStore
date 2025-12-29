PROYECTO: Pruebas de Servicios REST – PetStore

OBJETIVO:
Validar el correcto funcionamiento del CRUD de usuarios del API PetStore
utilizando la herramienta Karate para pruebas de servicios REST.

HERRAMIENTAS UTILIZADAS:
- Java 11 o superior
- Maven
- Karate Framework
- API pública: https://petstore.swagger.io/v2

ESTRUCTURA DEL PROYECTO:
- src/test/resources/petstore/PetStore.feature
  Contiene los escenarios de prueba:
  - Crear usuario
  - Buscar usuario creado
  - Actualizar nombre y correo
  - Buscar usuario actualizado
  - Eliminar usuario

- src/test/java/runner/
  Contiene la clase Runner para ejecutar las pruebas con JUnit.

- target/karate-reports/
  Carpeta generada automáticamente con los reportes HTML de Karate.

REQUISITOS PREVIOS:
1. Tener Java instalado y configurado en el PATH.
2. Tener Maven instalado.
3. Contar con conexión a internet (API PetStore es pública).

PASOS PARA EJECUTAR LAS PRUEBAS:

1. Clonar el repositorio público:
   git clone <URL_DEL_REPOSITORIO>
   cd <NOMBRE_DEL_PROYECTO>

2. Ejecutar las pruebas con Maven:
   mvn test

3. Ver los reportes de ejecución:
   Abrir en un navegador el archivo:
   target/karate-reports/karate-summary.html

CONSIDERACIONES:
- Los datos del usuario (username, id, email) se generan de forma dinámica
  para evitar conflictos con ejecuciones previas.
- Se utiliza un archivo JSON temporal en la carpeta target para reutilizar
  datos entre escenarios.
- Los escenarios son independientes y reproducibles.
