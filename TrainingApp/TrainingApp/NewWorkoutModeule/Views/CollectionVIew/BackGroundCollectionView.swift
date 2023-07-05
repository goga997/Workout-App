//
//  BackGroundCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class BackGroundCollectionView: UIView {
    
    private let imagesCollectionView = ImagesCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imagesCollectionView)
    }
    
    public func setDelegate(_ delegate: ImagineProtocol?) {
        imagesCollectionView.imagineDelegate = delegate
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imagesCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imagesCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imagesCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            imagesCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
        ])
    }
}

