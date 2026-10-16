package com.atp.cicd_demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/greet")
public class GreetingsController {
	
	@Value("${app.greet}")
	private String greet;
	
	@GetMapping
	public String greeting() {
		
		return "Hello %s".formatted(greet);
		
	}

}
