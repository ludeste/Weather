//
//  WeatherAddCityViewController.swift
//  Weather
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import UIKit
import DataKit
import MapKit

class WeatherAddCityViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet private weak var tableView: UITableView! {
		didSet {
			self.tableView.delegate = self
			self.tableView.dataSource = self
		}
	}
	
	private lazy var cityList: Set<WeatherCity> = {
		UserDefaultsManager.shared.cityList
	}() {
		didSet {
			UserDefaultsManager.shared.cityList = self.cityList
			// TODO: - send notif
			self.tableView.reloadData()
		}
	}
	
	// MARK: - View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Ajouter"
	}
}

// MARK: - UITableViewDelegate
extension WeatherAddCityViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
		return cell
	}
}
