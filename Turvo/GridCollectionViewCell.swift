//
//  ListCollectionViewCell.swift
//  Turvo
//
//  Created by Subins on 29/06/17.
//  Copyright © 2017 subins. All rights reserved.
//

import UIKit
import SDWebImage

class GridCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var locationImageView: UIImageView!
	@IBOutlet weak var locationNameLabel: UILabel!

	var locaton: Location? {
		didSet {
			locationNameLabel.text = locaton?.name
			locationImageView.sd_setImage(with: URL(string: (locaton?.image)!),
			                              placeholderImage: UIImage(named: "Placeholder"))
		}
	}
}
