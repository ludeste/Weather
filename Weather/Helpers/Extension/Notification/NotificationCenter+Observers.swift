//
//  NotificationCenter+Observers.swift
//  Weather
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import Foundation

extension NotificationCenter {
	
	public func addObservers(_ notifications: Notification.Name...,
					  queue: OperationQueue = .main,
					  completion: @escaping ((Notification) -> Void)) {
		notifications
			.forEach {
				_ = NotificationCenter
					.default
					.addObserver(forName: $0,
								 object: nil,
								 queue: queue) { notification in
						completion(notification)
					}
			}
	}
}
