package petstore;

import com.intuit.karate.junit5.Karate;

class PetStoreRunnerTest {
	
	@Karate.Test
	Karate runPetStore() {
		return Karate.run("classpath:petstore/PetStore.feature");
	}

}