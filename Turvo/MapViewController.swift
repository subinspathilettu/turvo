//
//  MapViewController.swift
//  Turvo
//
//  Created by Subins on 26/06/17.
//  Copyright © 2017 subins. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!
	var selectedLocation: Location?

	override func viewDidLoad() {
		super.viewDidLoad()
		LocationManager.shared.registerForLocationUpdate(self,
		                                                 selector: #selector(locationsUpdated(_:)))
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		addLocations()
		let location = selectedLocation != nil ? selectedLocation : LocationManager.shared.locations.first
		setMapRegion(location!)
		selectedLocation = nil
	}

	func locationsUpdated(_ notification: Notification) {
		addLocations()
	}

	func addLocations() {
		removeLocationsFromMap()
		for location in LocationManager.shared.locations {
			let annotation = MKPointAnnotation()
			annotation.title = location.name
			annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!,
			                                               longitude: location.longitude!)
			mapView.addAnnotation(annotation)
		}
	}

	func removeLocationsFromMap() {
		mapView.removeAnnotations(mapView.annotations)
	}

	func setMapRegion(_ location: Location) {
		let latDelta:CLLocationDegrees = 0.25
		let lonDelta:CLLocationDegrees = 0.25
		let span = MKCoordinateSpanMake(latDelta, lonDelta)
		let location = CLLocationCoordinate2DMake(location.latitude!,
												  location.longitude!)
		let region = MKCoordinateRegionMake(location, span)
		mapView.setRegion(region, animated: false)
	}
}
