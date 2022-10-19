//
//  AppDelegate.swift
//  Weather
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window:UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UIStoryboard(name: "Weather", bundle: nil).instantiateInitialViewController()
		window?.makeKeyAndVisible()
		
		return true
	}
}

