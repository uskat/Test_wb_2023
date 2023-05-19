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
}

class CustomLabel: UILabel {

    init(textAligment: NSTextAlignment, textColor: UIColor,
         fontSize: CGFloat, fontWeight: UIFont.Weight,
         text: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.text = text
        self.textAlignment = textAligment
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
