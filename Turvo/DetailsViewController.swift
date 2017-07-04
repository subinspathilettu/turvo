//
//  DetailsViewController.swift
//  Turvo
//
//  Created by Subins on 04/07/17.
//  Copyright © 2017 subins. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

	var location: Location?

	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var highLightsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		setTitle()
		setImageView()
		addLocation()
		setHighLights()
    }

	func setTitle() {
		titleLabel.text = location?.name
	}

	func setImageView() {
		imageView.sd_setImage(with: URL(string: (location?.image)!),
		                      placeholderImage: UIImage(named: "Placeholder"))
	}

	func addLocation() {
		//Add annotaion to map view
		let annotation = MKPointAnnotation()
		annotation.title = location?.name
		annotation.coordinate = CLLocationCoordinate2D(latitude: (location?.latitude!)!,
		                                               longitude: (location?.longitude!)!)
		mapView.addAnnotation(annotation)

		// Set map region
		let latDelta:CLLocationDegrees = 0.25
		let lonDelta:CLLocationDegrees = 0.25
		let span = MKCoordinateSpanMake(latDelta, lonDelta)
		let locationCoordinate = CLLocationCoordinate2DMake((location?.latitude)!,
		                                         (location?.longitude)!)
		let region = MKCoordinateRegionMake(locationCoordinate, span)
		mapView.setRegion(region, animated: false)
	}

	func setHighLights() {
		highLightsTableView.reloadData()
	}

	//MARK: Actions
	func mapButtonAction(_ sender: Any) {

	}
}

extension DetailsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let highLights = location?.highLights {
			return highLights.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "HighLights"
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")

		if cell == nil {
			cell = UITableViewCell(style: .default, reuseIdentifier: "CellIdentifier")
		}

		if let highLights = location?.highLights {
			cell?.textLabel?.text = highLights[indexPath.row]
		}

		return cell!
	}
}
