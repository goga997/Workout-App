//
//  WeatherView.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherStatusLabel: UILabel = {
       let label = UILabel()
        label.text = "Very Sunny"
        label.numberOfLines = 1
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Perfect weathert to go outside for workout!"
        label.adjustsFontSizeToFitWidth = true
        label.font = .robotoMedium14()
        label.minimumScaleFactor = 0.9
        label.numberOfLines = 0
        label.textColor = .specialGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.addShadowToView()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(weatherIcon)
        self.addSubview(weatherStatusLabel)
        self.addSubview(weatherDescriptionLabel)
    }
    
}
//MARK: - Layouts

extension WeatherView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            weatherIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
            
            weatherStatusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            weatherStatusLabel.trailingAnchor.constraint(equalTo: weatherIcon.leadingAnchor, constant: -10),
            weatherStatusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 8),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: weatherIcon.leadingAnchor, constant: -10),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
