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
	var locations: [Location]?

	override func viewDidLoad() {
		super.viewDidLoad()
		LocationManager.shared.registerForLocationUpdate(self,
		                                                 selector: #selector(locationsUpdated(_:)))
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		addLocations()
	}

	func locationsUpdated(_ notification: Notification) {
		addLocations()
	}

	func addLocations() {
		if locations == nil  {
			locations = LocationManager.shared.locations
		}

		removeLocationsFromMap()
		for location in locations! {
			let annotation = MKPointAnnotation()
			annotation.title = location.name
			annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!,
			                                               longitude: location.longitude!)
			mapView.addAnnotation(annotation)
		}
		setMapRegion()
	}

	func removeLocationsFromMap() {
		mapView.removeAnnotations(mapView.annotations)
	}

	func setMapRegion() {
		if let location = LocationManager.shared.locations.first {
			let latDelta:CLLocationDegrees = 0.25
			let lonDelta:CLLocationDegrees = 0.25
			let span = MKCoordinateSpanMake(latDelta, lonDelta)
			let location = CLLocationCoordinate2DMake(location.latitude!,
			                                          location.longitude!)
			let region = MKCoordinateRegionMake(location, span)
			mapView.setRegion(region, animated: false)
		}
	}
}
