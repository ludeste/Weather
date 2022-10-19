//
//  String+HighLight.swift
//  Weather
//
//  Created by Ludovic estevenet on 19/10/2022.
//

import UIKit

extension String {
	
	func highlight(range: [NSValue], size: CGFloat = 12) -> NSMutableAttributedString {
		
		let attributedText = NSMutableAttributedString(string: self)
		attributedText.addAttribute(NSAttributedString.Key.font,
									value: UIFont.systemFont(ofSize: size),
									range:NSMakeRange(0, self.count))

		for value in range {
			attributedText.addAttribute(NSAttributedString.Key.font,
										value: UIFont.boldSystemFont(ofSize: size),
										range: value.rangeValue)
		}
		
		return attributedText
		
	}
}
