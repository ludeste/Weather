//
//  WeatherCityResponse.swift
//  DataKit
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import Foundation

// MARK: - WeatherCityResponse
public struct WeatherCityResponse: Codable {
	
	// MARK: - Clouds
	public struct Clouds: Codable {
		public let all: Int
	}

	// MARK: - Main
	public struct Main: Codable {
		public let temp, feelsLike, tempMin, tempMax: Double
		public let pressure, humidity: Int
	}

	// MARK: - Weather
	public struct Weather: Codable {
		public let id: Int
		public let main, weatherDescription, icon: String
	}

	public let weather: [Weather]
	public let main: Main
	public let clouds: Clouds
}
