package com.blurdel.demo.controllers;

import java.util.concurrent.atomic.AtomicLong;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


/**
 * REST Controller will return the standard Hello Greeting
 * <p>
 * http://localhost:8080/hello
 * <br>
 * Returns "Hello World"
 * <p>
 * http://localhost:8080/hello?name=Fred
 * <br>
 * Returns "Hello Fred"
 *
 */
@Lazy
@RestController
@RequestMapping("/hello")
public class HelloController {

	private static final Logger LOG = LoggerFactory.getLogger(HelloController.class);
	
	private final AtomicLong mCount = new AtomicLong();
	
	private static final String sTemplate = "Hello %s!";
	
		
	public HelloController() {
		LOG.info("HelloController::");
	}
	
	@RequestMapping
	public String getHello(@RequestParam(value="name", defaultValue="World!") String name) {
		LOG.info("Num requests: " + mCount.incrementAndGet());
		return String.format(sTemplate, name);
	}
	
}
