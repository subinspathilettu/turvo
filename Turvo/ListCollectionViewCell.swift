//
//  ListCollectionViewCell.swift
//  Turvo
//
//  Created by Subins on 29/06/17.
//  Copyright © 2017 subins. All rights reserved.
//

import UIKit
import SDWebImage

class ListCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var locationImageView: UIImageView!
	@IBOutlet weak var locationNameLabel: UILabel!

	var location: Location? {
		didSet {
			locationNameLabel.text = location?.name
			locationImageView.sd_setImage(with: URL(string: (location?.image)!),
			                              placeholderImage: UIImage(named: "Placeholder"))
		}
	}
}
