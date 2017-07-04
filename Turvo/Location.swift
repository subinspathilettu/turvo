//
//  Location.swift
//  Turvo
//
//  Created by Subins on 26/06/17.
//  Copyright © 2017 subins. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Mappable {
	var name: String?
	var icon: String?
	var image: String?
	var latitude: Double?
	var longitude: Double?
	var highLights: [String]?


	required init?(map: Map){
	}

	func mapping(map: Map) {
		name <- map["name"]
		icon <- map["icon"]
		image <- map["image"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		highLights <- map["highlights"]
	}
}

class LocationObject: Mappable {
	var rawURL: String?

	required init?(map: Map){
	}

	func mapping(map: Map) {
		rawURL <- map["locations.raw_url"]
	}
}
