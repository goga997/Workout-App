//
//  WeatherView.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

class WeatherView: UIView {
    
    let activityIndicator: UIActivityIndicatorView = {
       let actIndic = UIActivityIndicatorView()
        actIndic.style = .large
        actIndic.color = .specialDarkGreen
        actIndic.hidesWhenStopped = true
        actIndic.translatesAutoresizingMaskIntoConstraints = false
        return actIndic
    }()
    
    private let weatherStatusLabel: UILabel = {
       let label = UILabel()
        label.text = "Loading..."
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "There is no data for Weather :("
        label.adjustsFontSizeToFitWidth = true
        label.font = .robotoMedium14()
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.textColor = .specialGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let weatherIcon: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "sun")
        image.isHidden = true
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
        self.addSubview(activityIndicator)
        self.addSubview(weatherStatusLabel)
        self.addSubview(weatherDescriptionLabel)
    }
    
    public func updateImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        activityIndicator.stopAnimating()
        weatherIcon.isHidden = false
        weatherIcon.image = image
    }
    
    public func updateLabels(model: WeatherModel) {
        weatherStatusLabel.text = model.name + " - " + model.weather[0].weatherDescription + " \(model.main.temperatureCelsius)°C"
      
        switch model.weather[0].weatherDescription {
        case "clear sky": weatherDescriptionLabel.text = "Perfect Weather to get outside\nYou should go for a training!"
        case "few clouds": weatherDescriptionLabel.text = "No worries, quite cloudy but still nice to train!"
        case "scattered clouds": weatherDescriptionLabel.text = "There is cloudy outside, but you can train!"
        case "broken clouds": weatherDescriptionLabel.text = "There is cloudy outside!"
        case "shower rain": weatherDescriptionLabel.text = "Take care maybe you do not want to get wet!"
        case "snow": weatherDescriptionLabel.text = "Maybe it will be better if you will train at home!"
        case "rain": weatherDescriptionLabel.text = "There is rain outside, you do not think about a training today!"
        case "thunderstorm": weatherDescriptionLabel.text = "Forget about training :)"
            
        default: weatherDescriptionLabel.text = "No matter what, you should go for a train!"
        }
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
            
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            activityIndicator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            activityIndicator.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
            
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
