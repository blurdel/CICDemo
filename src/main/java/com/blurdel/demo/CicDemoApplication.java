package com.blurdel.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


/**
 * 
 * A simple CICD demo example
 *
 * <p>Easiest way to run this: 
 * <br>mvn exec:java -Dexec.mainClass="com.blurdel.demo.CicDemoApplication" 
 *
 */
@SpringBootApplication
public class CicDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(CicDemoApplication.class, args);
	}

}
