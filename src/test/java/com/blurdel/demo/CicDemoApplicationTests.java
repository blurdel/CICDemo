package com.blurdel.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CicDemoApplicationTests {

	@Test
	void good() {
		int count = 3;
		assert count == 3;
	}
	
	@Test
	void bad() {
		int count = 3;
		assert count == 0;
	}
	
	@Test
	void other() {
		int count = 3;
		assert count == 3;
	}

}
