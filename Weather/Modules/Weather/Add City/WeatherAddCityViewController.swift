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
	
	// MARK: - Variables
	private lazy var searchController: UISearchController = {
		let search = UISearchController(searchResultsController: nil)
		search.searchResultsUpdater = self
		search.obscuresBackgroundDuringPresentation = false
		search.searchBar.placeholder = "Rechercher une ville"
		search.definesPresentationContext = true
		return search
	}()
	
	private lazy var searchCompleter: MKLocalSearchCompleter = {
		let completer = MKLocalSearchCompleter()
		completer.delegate = self
		completer.filterType = .locationsOnly
		return completer
	}()

	private lazy var cityList: Set<WeatherCity> = {
		UserDefaultsManager.shared.cityList
	}() {
		didSet {
			UserDefaultsManager.shared.cityList = self.cityList
			NotificationCenter.default.post(name: .cityList, object: nil)
			self.tableView.reloadData()
		}
	}
	
	private var results: [MKLocalSearchCompletion] = [] {
		didSet {
			self.tableView.reloadData()
		}
	}
	
	// MARK: - View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.searchController = self.searchController
		self.navigationItem.hidesSearchBarWhenScrolling = false
		
		self.cityList = UserDefaultsManager.shared.cityList
		self.title = "Ajouter"
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.navigationItem.hidesSearchBarWhenScrolling = true
	}
}

// MARK: - UISearchResultsUpdating
extension WeatherAddCityViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
	 
	  if let searchText = searchController.searchBar.text, !searchText.isEmpty {
		  self.searchCompleter.queryFragment = searchText
	  } else {
		  self.results = []
	  }
  }
}

// MARK: - MKLocalSearchCompleterDelegate
extension WeatherAddCityViewController: MKLocalSearchCompleterDelegate {
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		
		results = completer.results.filter { !$0.subtitle.contains(",") && !$0.subtitle.isEmpty }
	}
	
	func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {}
}

// MARK: - UITableViewDelegate
extension WeatherAddCityViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.results.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let result = self.results[indexPath.row]
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
		cell.textLabel?.attributedText = result.title.highlight(range: result.titleHighlightRanges, size: 17)
		cell.detailTextLabel?.attributedText = result.subtitle.highlight(range: result.subtitleHighlightRanges)
		cell.accessoryType = self.cityList.contains { $0.title == result.title } ? .checkmark : .none
		cell.selectionStyle = .none

		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let completion = results[indexPath.row]
		let searchRequest = MKLocalSearch.Request(completion: completion)
		let search = MKLocalSearch(request: searchRequest)
		search.start { response, _ in
			if let coordinate = response?.mapItems[0].placemark.coordinate {
				
				self.cityList = UserDefaultsManager.shared.cityList
					.symmetricDifference([WeatherCity(title: completion.title, coordinate: coordinate)])
			}
		}
	}
}
