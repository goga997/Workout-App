//
//  GreenButton.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class GreenButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .specialGreen
        titleLabel?.font = .robotoBold16()
        tintColor = .white
        layer.cornerRadius = 10
        self.addShadowToView()
        translatesAutoresizingMaskIntoConstraints = false
    }
}

