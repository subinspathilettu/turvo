//
//  LocationWebService.swift
//  Turvo
//
//  Created by Subins on 26/06/17.
//  Copyright © 2017 subins. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias LocationFetchCallBack = (_ locations: [Location]?, _ error: Error?) -> Void

class LocationFetchWebService {

	static let locationFetchURL = "https://api.github.com/gists/d9efd474a0d3a460f5e4453b3508ffde"

	func fetchLocations(_ callback: @escaping LocationFetchCallBack) {
		getRawURL { (rawURL, error) in
			if error == nil {
				self.fetchLocations(rawURL!,
				                    callback: callback)
			} else {
				callback(nil, error)
			}
		}
	}

	fileprivate func fetchLocations(_ URL: String, callback: @escaping LocationFetchCallBack) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		Alamofire.request(URL).responseArray { (response: DataResponse<[Location]>) in

			let locations = response.result.value
			if let locations = locations {
				callback(locations, nil)
			} else if let error = response.error {
				callback(nil, error)
			}
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
	}

	fileprivate func getRawURL(_ callback: @escaping (_ rawURL: String?, _ error: Error?) -> Void) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		let URL = LocationFetchWebService.locationFetchURL
		Alamofire.request(URL).responseObject(keyPath: "files") {
			(response: DataResponse<LocationObject>) in

			if let locationObject = response.result.value {
				callback(locationObject.rawURL, nil)
			} else if let error = response.error {
				callback(nil, error)
			}
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
	}
}
