//
//  StackViewExtension.swift
//  TrainingApp
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
