//
//  WeatherWorker.swift
//  DataKit
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import Foundation

public struct WeatherWorker {
	
	public init() { }
	
	public func getWeather(for city: WeatherCity?, completion: @escaping (WeatherCityResponse) -> Void) {

		guard let city, let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(city.coordinate.latitude)&lon=\(city.coordinate.longitude)&units=metric&appid=69bbc60b82fa9bfd5fa962bd393c875b") else {
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else { return }
			
			do {
				let response = try JSONDecoder().decode(WeatherCityResponse.self, from: data)
				completion(response)
			} catch {
				print(error)
			}
		}
		task.resume()
	}
}
