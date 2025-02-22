package com.msc.project.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.msc.project.service.PredictionService;

@RestController
@RequestMapping("/api/predict")
public class PredictionController {
	
	@Autowired
	private PredictionService predictionService;

	@PostMapping
	public ResponseEntity<String> predict() {
		try {
			return ResponseEntity
					.ok(predictionService.getPrediction());
		} catch (IOException e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
			return ResponseEntity.internalServerError()
					.body("Error occured on prediction Service");
		}
	}
}
