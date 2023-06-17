//
//  UIViewExtension.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

extension UIView {
    
    func addShadowToView() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 7)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4
    }
    
}
