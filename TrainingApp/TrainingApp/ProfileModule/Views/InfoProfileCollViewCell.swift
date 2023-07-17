//
//  InfoProfileCollViewCell.swift
//  TrainingApp
//
//  Created by Grigore on 06.07.2023.
//

import UIKit

class InfoProfileCollViewCell: UICollectionViewCell {
    
    private let numberLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.text = "180"
        label.textColor = .white
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "colection2")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel = UILabel(text: "BICEPS", font: .robotoBold28(), textColor: .white)
    
    //MARK: - INITS
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        layer.cornerRadius = 20
        backgroundColor = .specialDarkYellow
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.6
        addSubview(nameLabel)
        
        addSubview(workoutImageView)
        addSubview(numberLabel)
    }
    
    public func configure(model: ResultWorkout) {
        nameLabel.text = model.name
        numberLabel.text = "\(model.result)"
        
        guard let data = model.imageData else { return }
        let image = UIImage(data: data)
        workoutImageView.image = image?.withRenderingMode(.alwaysTemplate)
    }
    
}

//MARK: - Layouts
extension InfoProfileCollViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            
            workoutImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            workoutImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            workoutImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            workoutImageView.widthAnchor.constraint(equalTo: workoutImageView.heightAnchor),
            
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            numberLabel.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor)
        ])
    }
}
