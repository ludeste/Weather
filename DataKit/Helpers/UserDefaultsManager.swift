//
//  UserDefaultsManager.swift
//  DataKit
//
//  Created by Ludovic estevenet on 19/10/2022.
//

@propertyWrapper
public struct OptionalUserDefaultsValue<T: Codable> {
	let key: UserDefaultsManager.Key
	
	public var wrappedValue: T? {
		get {
			guard let data = UserDefaultsManager.shared.defaults.data(forKey: key.rawValue) else { return nil }
			return (try? JSONDecoder().decode(T.self, from: data))
		}
		set {
			UserDefaultsManager.shared.defaults.set(try? JSONEncoder().encode(newValue), forKey: key.rawValue)
			UserDefaultsManager.shared.defaults.synchronize()
		}
	}
}

@propertyWrapper
public struct UserDefaultsValue<T: Codable> {
	let key: UserDefaultsManager.Key
	let defaultValue: T
	
	public var wrappedValue: T {
		get {
			guard let data = UserDefaultsManager.shared.defaults.data(forKey: key.rawValue) else { return defaultValue }
			return (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
		}
		set {
			UserDefaultsManager.shared.defaults.set(try? JSONEncoder().encode(newValue), forKey: key.rawValue)
			UserDefaultsManager.shared.defaults.synchronize()
		}
	}
}

public class UserDefaultsManager {
	
	enum Key: String, CaseIterable {
		case cityList
	}
	
	// MARK: - Singleton
	public static let shared = UserDefaultsManager()
	
	// MARK: - Variables
	fileprivate let defaults: UserDefaults
	
	@UserDefaultsValue(key: .cityList, defaultValue: [])
	public var cityList: Set<WeatherCity>
	
	// MARK: - Init
	private init() {
		self.defaults = UserDefaults(suiteName: "Weather") ?? .standard
	}
}
