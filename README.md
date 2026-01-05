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

NOTA SOBRE LA EJECUCIÓN BDD CON KARATE:

Las pruebas están implementadas bajo el enfoque BDD utilizando Karate,
mediante archivos `.feature` con sintaxis Gherkin.

Al ejecutar el comando:

mvn test

Karate ejecuta los escenarios definidos en los archivos `.feature` y genera
automáticamente los reportes HTML.

Nota: Durante la ejecución, Maven/JUnit puede mostrar `Tests run: 0`.
Este comportamiento es esperado en proyectos Karate, ya que la ejecución
de los escenarios BDD se gestiona internamente por el framework.
La evidencia de ejecución se encuentra en el reporte:

target/karate-reports/karate-summary.html

CONSIDERACIONES:
- Los datos del usuario (username, id, email) se generan de forma dinámica
  para evitar conflictos con ejecuciones previas.
- Se utiliza un archivo JSON temporal en la carpeta target para reutilizar
  datos entre escenarios.
- Los escenarios son independientes y reproducibles.