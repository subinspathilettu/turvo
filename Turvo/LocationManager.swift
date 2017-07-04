//
//  LocationManager.swift
//  Turvo
//
//  Created by Subins on 04/07/17.
//  Copyright © 2017 subins. All rights reserved.
//

import Foundation

class LocationManager {
	static let shared = LocationManager()
	var locations = [Location]()

	fileprivate let notificationName = Notification.Name("UpdatedLocations")

	func updateLocations() {
		let locationFetchWebService = LocationFetchWebService()
		locationFetchWebService.fetchLocations { locations, error in
			if error == nil {
				self.locations.removeAll()
				self.locations = locations!
				self.sendSuccessNotification()
			}
		}
	}

	func sendSuccessNotification() {
		NotificationCenter.default.post(name: notificationName,
		                                object: locations)
	}

	func registerForLocationUpdate(_ target: Any, selector: Selector) {
		NotificationCenter.default.addObserver(target,
		                                       selector: selector,
		                                       name: notificationName,
		                                       object: nil)
	}
}
