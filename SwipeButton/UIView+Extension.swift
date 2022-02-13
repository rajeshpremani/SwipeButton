//
//  UIView+Extension.swift
//  SwipeButton
//
//  Created by Rajesh Kumar Sahil on 12/02/2022.
//

import Foundation
import UIKit


extension UIView {
    
    func fillInSuperview(insets: UIEdgeInsets = .zero) {
        guard let viewSuperView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        fill(leading: viewSuperView.leadingAnchor, trailing: viewSuperView.trailingAnchor, top: viewSuperView.topAnchor, bottom: viewSuperView.bottomAnchor, insets: insets)
    }
    
    func fill(leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let left = leading {
            leadingAnchor.constraint(equalTo: left, constant: insets.left).isActive = true
        }
        
        if let right = trailing {
            trailingAnchor.constraint(equalTo: right, constant: -insets.right).isActive = true
        }
        
        set(top: top, constant: insets.top)
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom).isActive = true
        }
    }
    
    func set(top: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) {
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: constant).isActive = true
        }
    }

}
