//
//  WeatherCityListViewController.swift
//  Weather
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import UIKit
import MapKit
import DataKit

class WeatherCityListViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet private weak var tableView: UITableView! {
		didSet {
			self.tableView.delegate = self
			self.tableView.dataSource = self
		}
	}
	
	// MARK: - Variables
	var cityList: [WeatherCity] = []
	
	// MARK: - View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Villes"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
		
		// TODO: - remove
		self.cityList = [WeatherCity(title: "test", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))]
		
		self.updateList()
		// TODO: - Notif
	}
	
	// MARK: - Utils
	private func updateList() {
		// TODO: - sort list
		self.tableView.reloadData()
	}
	
	// MARK: - Actions
	@objc private func addTapped() {
		let storyBoard = UIStoryboard(name: "Weather", bundle: nil)
		if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherAddCityViewController") as? WeatherAddCityViewController {
			self.navigationController?.pushViewController(nextViewController, animated: true)
			
		}
	}
}

// MARK: - UITableViewDelegate
extension WeatherCityListViewController: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.cityList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
		cell.textLabel?.text = self.cityList[indexPath.row].title
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let storyBoard = UIStoryboard(name: "Weather", bundle: nil)
		if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherCityDetailsViewController") as? WeatherCityDetailsViewController {
			nextViewController.city = self.cityList[indexPath.row]
			self.navigationController?.pushViewController(nextViewController, animated: true)
			
		}
	}
}
