//
//  TimerWorkoutViewController.swift
//  TrainingApp
//
//  Created by Grigore on 01.07.2023.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    private let startWorkoutLabel = UILabel(text: "START WORKOUT", font: .robotoBold24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timerIndicator: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ellipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Detailes")
    
    private let infoView = TimerWorkoutParametersView()
    
    private lazy var finishButton = GreenButton(text: "FINISH")
    
    private var workoutModel = WorkoutModel()
    
    //MARK: - LIFE CYCLE + viewSetUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(timerIndicator)
        view.addSubview(detailsLabel)
        view.addSubview(infoView)
        view.addSubview(finishButton)
    }
 
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    public func setWorkoutModel(_ model: WorkoutModel) {
        workoutModel = model
    }
}

extension TimerWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            
            
            timerIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerIndicator.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 30),
            timerIndicator.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.67),
            //            timerIndicator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            
            detailsLabel.topAnchor.constraint(equalTo: timerIndicator.bottomAnchor, constant: 30),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.widthAnchor.constraint(equalToConstant: 60),
            detailsLabel.heightAnchor.constraint(equalToConstant: 15),
            
            infoView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            finishButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 25),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            finishButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.135)
        ])
    }
}

