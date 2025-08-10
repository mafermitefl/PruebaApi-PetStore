Feature: Pruebas ApPI PetStore

    Background:
		* url 'https://petstore.swagger.io/v2'
		* configure headers = { accept: 'application/json' }
		* def petID = Math.floor(Math.random()*1000000)
		* def newPet =
		"""
		{
		"id": #(petID),
		"category": { "id": 0, "name": "dogs" },
		"name": "Alaska",
		"photoUrls": [ "string" ],
		"tags": [ { "id": 0, "name": "demo" } ],
		"status": "available"
		}
		"""
		
    Scenario: Anadir una mascota a la tienda
		Given path "pet"
		And request newPet
		When method post
		* def data = { petID: "#(response.id)" }
		* def filePath = karate.write(data, "pet_id.json")
		Then status 200
		And match response.id == petID
		And match response.name == "Alaska"
		And match response.status == "available"
		
    Scenario: Consultar mascota por ID
		* def pet_id = read("file:target/pet_id.json")
		* def pet_idSave = pet_id.petID
		Given path "pet", pet_idSave
		* configure retry = { count: 10, interval: 2000}
		And retry until responseStatus == 200
		And request newPet
		When method get
		Then status 200
		And match response.id == pet_idSave

	Scenario: Actualizar nombre y status a "sold"
		* def pet_id = read("file:target/pet_id.json")
		* def pet_idSave = pet_id.petID

		Given path "pet", pet_idSave
		And form field name = "Sammy"
		And form field status = "sold"
		* configure retry = { count: 10, interval: 2000}
		And retry until responseStatus == 200
		When method post
		Then status 200
		
	Scenario: Consultar mascota modificada por status
		* def pet_id = read("file:target/pet_id.json")
		* def pet_idSave = pet_id.petID
		Given path "pet", "findByStatus"
		And param status = "sold"
		* configure retry = { count: 100, interval: 2000}
		And retry until response.find(x => x && x.id == pet_idSave) != null
		When method get
		Then status 200