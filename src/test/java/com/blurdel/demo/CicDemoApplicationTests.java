package com.blurdel.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CicDemoApplicationTests {

	@Test
	void contextLoads() {
		int count = 3;
		assert count == 3;
	}

}
