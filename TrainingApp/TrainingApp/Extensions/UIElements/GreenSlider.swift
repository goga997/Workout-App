//
//  GreenSlider.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class GreenSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(minimumValue: Float, maximumValue: Float) {
        self.init(frame: .zero)
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.minimumTrackTintColor = .specialGreen
        self.maximumTrackTintColor = .specialLightBrown
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
