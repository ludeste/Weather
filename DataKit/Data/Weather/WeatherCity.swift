//
//  WeatherCity.swift
//  DataKit
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import CoreLocation

public struct WeatherCity: Codable, Hashable {
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.title)
	}
	
	public static func == (lhs: WeatherCity, rhs: WeatherCity) -> Bool {
		lhs.title == rhs.title
	}
	
	public var title: String
	public var coordinate: CLLocationCoordinate2D
	
	public init(title: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.coordinate = coordinate
	}
}
