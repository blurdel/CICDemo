package com.blurdel.demo.controllers;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Lazy
@RestController
@RequestMapping("/hello")
public class HelloController {

	private static final Logger LOG = LoggerFactory.getLogger(HelloController.class);
	
	
	public HelloController() {
		LOG.info("HelloController::");
	}
	
	@RequestMapping
	public String getHello() {
		return "CICD Demo: " + new Date().toString();
	}
	
}
