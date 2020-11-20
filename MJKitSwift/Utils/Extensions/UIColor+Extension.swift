//
//  UIColor+Extension.swift
//  SwiftStudy
//
//  Created by MJ on 05/03/2019.
//  Copyright © 2019 MJ. All rights reserved.
//

import UIKit

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}

	
	/// 색상을 색상코드로 변환하는 메소드 ex)"4F9BF5"
	///
	/// - Parameters:
	///   - hexFromString: ex) "4F9BF5" ...
	///   - alpha: ex) 0.1, 1.0 ...
	convenience init(hexFromString:String, alpha:CGFloat) {
		var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
		
		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}
		
		if ((cString.count) == 6) {
			Scanner(string: cString).scanHexInt32(&rgbValue)
		}
		
		self.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: alpha
		)
	}
	
}
