Feature: Pruebas API PetStore - User

	Background:
		* url 'https://petstore.swagger.io/v2'
		* configure headers = { accept: 'application/json', 'Content-Type': 'application/json' }

		# Datos dinámicos para evitar colisiones
		* def now = java.lang.System.currentTimeMillis()
		* def userId = now % 1000
		* def username = 'prueba_user_' + userId

		* def firstName = 'Mafer'
		* def lastName = 'Mietfl'
		* def email = 'mafer.' + username + '@example.com'
		* def password = 'Passw0rd!'
		* def phone = '+593999999999'
		* def userStatus = 1

		* def newUser =
		"""
		{
			"id": #(userId),
			"username": "#(username)",
			"firstName": "#(firstName)",
			"lastName": "#(lastName)",
			"email": "#(email)",
			"password": "#(password)",
			"phone": "#(phone)",
			"userStatus": #(userStatus)
		}
		"""

	Scenario: Crear un usuario
		Given path 'user'
		And request newUser
		When method post
		Then status 200
		And match response.code == 200

		# Guardar username e id en target para reuso (como tu ejemplo) 
		* def data = { username: "#(username)", userId: "#(userId)", email: "#(email)"}
		* def filePath = karate.write(data, 'user_data.json')
		* print 'CREADO =>', data, ' archivo:', filePath, ' response:', response

	Scenario: Buscar el usuario creado
		* def user_data = read('file:target/user_data.json')
		* def usernameSave = user_data.username

		Given path 'user', usernameSave
		* configure retry = { count: 10, interval: 1000 }
		And retry until responseStatus == 200
		When method get
		Then status 200

		And match response.username == usernameSave
		And match response.email == user_data.email
		And match response.id == user_data.userId


	Scenario: Actualizar el nombre y el correo del usuario
		* def user_data = read('file:target/user_data.json')
		* def usernameSave = user_data.username
		* def userIdSave = user_data.userId

		* def newFirstName = 'Juan-Updated'
		* def newEmail = 'updated.' + usernameSave + '@example.com'

		* def updateUser =
		"""
		{
			"id": #(userIdSave),
			"username": "#(usernameSave)",
			"firstName": "#(newFirstName)",
			"lastName": "#(lastName)",
			"email": "#(newEmail)",
			"password": "#(password)",
			"phone": "#(phone)",
			"userStatus": #(userStatus)
		}
		"""

		Given path 'user', usernameSave
		And request updateUser
		* configure retry = { count: 10, interval: 1000 }
		And retry until responseStatus == 200
		When method put
		Then status 200
		And match response.code == 200

		# Guardar nuevos datos para el siguiente escenario
		* def updated = { username: "#(usernameSave)", userId: "#(userIdSave)", firstName: "#(newFirstName)", email: "#(newEmail)" }
		* def filePath2 = karate.write(updated, 'user_updated.json')
		* print 'ACTUALIZADO =>', updated, ' archivo:', filePath2, ' response:', response

	Scenario: Buscar el usuario actualizado
		* def user_updated = read('file:target/user_updated.json')
		* def usernameSave = user_updated.username

		Given path 'user', usernameSave
		* configure retry = { count: 10, interval: 1000 }
		And retry until responseStatus == 200
		When method get
		Then status 200

		And match response.username == usernameSave
		And match response.firstName == user_updated.firstName
		And match response.email == user_updated.email
		* print 'CONSULTA ACTUALIZADO =>', response

	Scenario: Eliminar el usuario
		* def user_data = read('file:target/user_data.json')
		* def usernameSave = user_data.username

		Given path 'user', usernameSave
		* configure retry = { count: 10, interval: 1000 }
		And retry until responseStatus == 200
		When method delete
		Then status 200
		And match response.code == 200
		* print 'ELIMINADO =>', response

		# Validación extra: confirmar que ya no existe
		Given path 'user', usernameSave
		When method get
		Then status 404
		* print 'CONFIRMA 404 =>', response