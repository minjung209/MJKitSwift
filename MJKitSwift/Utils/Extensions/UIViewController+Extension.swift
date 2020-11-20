//
//  UIViewController+Extension.swift
//  SwiftInternalDB
//
//  Created by MJ on 22/07/2019.
//  Copyright © 2019 MJ. All rights reserved.
//

import UIKit

class ToastLabel: UILabel {
	var textInsets = UIEdgeInsets.zero {
		didSet { invalidateIntrinsicContentSize() }
	}
	
	override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
		let insetRect = bounds.inset(by: textInsets)
		let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
		let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
		
		return textRect.inset(by: invertedInsets)
	}
	
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: textInsets))
	}
}

extension UIViewController {
	
	static let DELAY_SHORT = 1.5
	static let DELAY_LONG = 3.0
	
	func showToast(_ text: String, delay: TimeInterval = DELAY_SHORT) {
		let label = ToastLabel()
		label.backgroundColor = UIColor(white: 0, alpha: 0.5)
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15)
		label.alpha = 0
		label.text = text
		label.clipsToBounds = true
		label.layer.cornerRadius = 20
		label.numberOfLines = 0
		label.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)
		
//		label.frame = CGRect(x: 0, y: view.getHeight() - 40.0, width: label.getWidth(), height: label.getHeight())
//		label.center = CGPoint(x: view.getWidth() / 2, y: view.getHeight() / 2)
		
		if #available(iOS 11.0, *) {
			let saveArea = view.safeAreaLayoutGuide
			label.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
			label.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
			label.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
			label.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: -50).isActive = true
			view.layoutIfNeeded()
		} else {
			
		}

		UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
			label.alpha = 1
		}, completion: { _ in
			UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
				label.alpha = 0
			}, completion: {_ in
				label.removeFromSuperview()
			})
		})
	}
	
	
//	func showToast(_ title:String, _ text:String){
//		let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
//		alert.view.backgroundColor = UIColor.black
//		alert.view.alpha = 0.6
//		alert.view.layer.cornerRadius = 15
//
//		self.present(alert, animated: true)
//
//		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
//			alert.dismiss(animated: true, completion: nil)
//		}
//	}
}

