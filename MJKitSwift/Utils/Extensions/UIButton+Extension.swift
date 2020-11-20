//
//  UIButto+Extension.swift
//  SwiftInternalDB
//
//  Created by MJ on 19/07/2019.
//  Copyright © 2019 MJ. All rights reserved.
//

import UIKit

extension UIButton{

	public func setRoundLayer(){
		self.layer.cornerRadius = 5.0
		self.clipsToBounds = true
	}
	
	public func setBorderLayer(){
		self.layer.borderColor = UIColor(hexFromString: "D3D3D3", alpha: 1.0).cgColor
		self.layer.borderWidth = 1.0
	}
}
