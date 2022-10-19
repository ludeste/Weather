//
//  WeatherCityDetailsViewController.swift
//  Weather
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import UIKit
import DataKit

class WeatherCityDetailsViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet private weak var imageContainer: UIView!
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var cityLabel: UILabel!
	@IBOutlet private weak var temperatureLabel: UILabel!
	@IBOutlet private weak var feelingLabel: UILabel!
	@IBOutlet private weak var humidityLabel: UILabel!
	
	// MARK: - Variables
	private var worker = WeatherWorker()
	
	var city: WeatherCity?
	
	// MARK: - View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.worker.getWeather(for: self.city) { [weak self] response in
			DispatchQueue.main.async {
				self?.updateUI(weatherInfo: response)
			}
		}
	}
	
	// MARK: - Utils
	private func updateUI(weatherInfo: WeatherCityResponse) {
		
		let weatherImage = UIImage(named: weatherInfo.weather.first?.icon ?? "")
		
		self.imageContainer.isHidden = weatherImage == nil
		self.imageView.image = weatherImage
		self.cityLabel.text = city?.title ?? ""
		self.temperatureLabel.text = "Température \(weatherInfo.main.temp)°C\n min: \(weatherInfo.main.tempMin)°C, max: \(weatherInfo.main.tempMax)°C"
		self.feelingLabel.text = "Ressenti \(weatherInfo.main.feelsLike)°C"
		self.humidityLabel.text = "Humidité \(weatherInfo.main.humidity)%"
	}
}
