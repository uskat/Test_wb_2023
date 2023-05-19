//
//  UIView ext.swift
//  test wb
//
//  Created by Diego Abramoff on 16.05.23.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat, isInteractive: Bool) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.isUserInteractionEnabled = isInteractive
    }
}

extension UILabel {

    convenience init(textAligment: NSTextAlignment, textColor: UIColor,
                     fontSize: CGFloat, fontWeight: UIFont.Weight, text: String = "") {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textAlignment = textAligment
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
}

extension UIStackView {

    convenience init(distrubution: UIStackView.Distribution, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = distrubution
        self.axis = axis
        self.spacing = spacing
    }
}
