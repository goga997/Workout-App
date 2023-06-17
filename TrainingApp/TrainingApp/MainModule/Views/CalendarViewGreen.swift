//
//  CalendarViewGreen.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

class CalendarViewGreen: UIView {
    
    private let collectionView = CalendarCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setUpView() {
        self.backgroundColor = .specialGreen
        self.layer.cornerRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(collectionView)
    }
}
//MARK: - Layouts

extension CalendarViewGreen {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
        ])
    }
}
