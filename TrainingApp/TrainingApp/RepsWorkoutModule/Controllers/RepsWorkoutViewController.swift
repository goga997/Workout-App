//
//  RepsWorkoutViewController.swift
//  TrainingApp
//
//  Created by Grigore on 01.07.2023.
//

import UIKit

class RepsWorkoutViewController: UIViewController {
    
    private let startWorkoutLabel = UILabel(text: "START WORKOUT", font: .robotoBold24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let womanImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sportsman")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Detailes")
    
    private let infoView = WorkoutParametersView()
    
    private lazy var finishButton = GreenButton(text: "FINISH")
    
    private var workoutModel = WorkoutModel()
    
    private let customAlert = CustomAlert()
    
    private var numberOfSet = 1
        
    //MARK: - LIFE CYCLE + viewSetUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        infoView.delegate = self
    }
    
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(womanImageView)
        view.addSubview(detailsLabel)
        
        infoView.refreshLabelsValue(model: workoutModel, numberOfSet: numberOfSet)
        view.addSubview(infoView)
        
        view.addSubview(finishButton)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }
 
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.setTrueStatusWorkoutModelForFinish(model: workoutModel)
        } else {
            self.presentAlertForFinishButton(title: "Warning",
                                             message: "You have not finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }
    
    public func setWorkoutModel(_ model: WorkoutModel) {
        workoutModel = model 
    }
}

// PROTOCOL NextSet
extension RepsWorkoutViewController: NextSetProtocol {
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            infoView.refreshLabelsValue(model: workoutModel, numberOfSet: numberOfSet)
        } else {
            presentSimpleAlert(title: "Error", message: "You have to finish your Workout")
        }
    }
    
    func editingTapped() {
        customAlert.presentCustomAlert(viewController: self, repsOrTimer: "Reps") { [weak self] sets, reps in
            guard let self = self else {return}
            if sets != "" && reps != "" {
                guard let numberOfSets = Int(sets), let numberOfReps = Int(reps) else { return }
                RealmManager.shared.updateSetsRepsWorkoutModel(model: self.workoutModel, sets: numberOfSets, reps: numberOfReps)
                self.infoView.refreshLabelsValue(model: self.workoutModel, numberOfSet: self.numberOfSet)
            }
        }
    }
}

//LAYOUTS
extension RepsWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),

            
            womanImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            womanImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 30),
            womanImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.67),
//            womanImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            
            detailsLabel.topAnchor.constraint(equalTo: womanImageView.bottomAnchor, constant: 30),
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