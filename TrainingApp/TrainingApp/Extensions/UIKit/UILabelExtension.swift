//
//  UILabelExtension.swift
//  TrainingApp
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.textColor = UIColor.specialLightBrown
        self.font = UIFont.robotoMedium14()
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
