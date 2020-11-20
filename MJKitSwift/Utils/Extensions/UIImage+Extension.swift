//
//  UIImage+Extension.swift
//  SwiftStudy
//
//  Created by MJ on 20/03/2019.
//  Copyright © 2019 MJ. All rights reserved.
//

import UIKit

extension UIImage {
	
	func scaleToSize(newSize: CGSize) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
		draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
		let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext();
		return newImage
	}
}


