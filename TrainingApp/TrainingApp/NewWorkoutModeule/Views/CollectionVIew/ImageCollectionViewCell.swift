//
//  ImageCellCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let backgroundImageCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let workoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "collection1")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet
        {
            if self.isSelected {
                backgroundImageCell.backgroundColor = .specialYellow
                backgroundImageCell.layer.borderWidth = 2
                backgroundImageCell.layer.borderColor = UIColor.black.cgColor
            } else {
                backgroundImageCell.backgroundColor = .specialBackground
                backgroundImageCell.layer.borderWidth = 0
                backgroundImageCell.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.layer.cornerRadius = 10
        
        self.addSubview(backgroundImageCell)
        self.addSubview(workoutImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageCell.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageCell.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            workoutImageView.topAnchor.constraint(equalTo: backgroundImageCell.topAnchor, constant: 6),
            workoutImageView.leadingAnchor.constraint(equalTo: backgroundImageCell.leadingAnchor, constant: 6),
            workoutImageView.trailingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: -6),
            workoutImageView.bottomAnchor.constraint(equalTo: backgroundImageCell.bottomAnchor, constant: -6)
        ])
    }
}
