//
//  Created by Honghao Zhang on 01/08/2016.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import UIKit

open class ImageView: UIImageView {
	open var rounded: Bool = false

	override open func layoutSubviews() {
		super.layoutSubviews()

		if rounded {
			layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
		}
	}
}
