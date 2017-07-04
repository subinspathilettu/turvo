//
//  ListViewController.swift
//  Turvo
//
//  Created by Subins on 26/06/17.
//  Copyright © 2017 subins. All rights reserved.
//

import UIKit

enum LocationViewMode {
	case list, grid
}

class ListViewController: UIViewController {

	@IBOutlet weak var locationCollectionView: UICollectionView!
	@IBOutlet weak var rightBarButtonItem: UIBarButtonItem!

	var locationViewMode = LocationViewMode.grid

	override func viewDidLoad() {
		super.viewDidLoad()
		LocationManager.shared.registerForLocationUpdate(self,
		                                                 selector: #selector(locationsUpdated(_:)))
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		locationCollectionView.reloadData()
	}

	//MARK: Actions
	@IBAction func toggleView(_ sender: UIBarButtonItem) {
		locationViewMode = (locationViewMode == .grid ? .list : .grid)
		locationCollectionView.reloadData()
	}

	func locationsUpdated(_ notification: Notification) {
		locationCollectionView.reloadData()
	}
}

extension ListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView,
	                    numberOfItemsInSection section: Int) -> Int {
		return LocationManager.shared.locations.count
	}

	func collectionView(_ collectionView: UICollectionView,
	                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		if locationViewMode == .list {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell",
			                                          for: indexPath) as? ListCollectionViewCell
			cell?.location = LocationManager.shared.locations[indexPath.row]
			return cell!
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell",
			                                              for: indexPath) as? GridCollectionViewCell
			cell?.locaton = LocationManager.shared.locations[indexPath.row]
			return cell!
		}
	}
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
	                    layout collectionViewLayout: UICollectionViewLayout,
	                    sizeForItemAt indexPath: IndexPath) -> CGSize {

		var size = collectionView.bounds.size
		if locationViewMode == .list {
			size.height = 60.0 //List view mode cell height
		} else {
			size.width = (collectionView.bounds.size.width / 2 ) - 10
			size.height = size.width
		}

		return size
	}
}

extension ListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let location = LocationManager.shared.locations[indexPath.row]
		let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
		controller?.location = location
		navigationController?.pushViewController(controller!, animated: true)
	}
}
