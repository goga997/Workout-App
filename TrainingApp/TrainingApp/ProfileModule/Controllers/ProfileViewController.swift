//
//  ProfileViewController.swift
//  TrainingApp
//
//  Created by Grigore on 06.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var resultWorkout = [ResultWorkout]()
    
    private let profileLabelTop: UILabel = {
        let label = UILabel()
        label.font = .robotoBold24()
        label.text = "PROFILE"
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let greenView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameProfileLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoBold28()
        label.text = "Grigore Rosca"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .none
        button.tintColor = .specialGreen
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.font = .robotoMedium18()
        button.setImage(UIImage(named: "profileEditing"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -10)
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heightLabel = UILabel(text: "Height: 165", font: .robotoMedium18(), textColor: .specialGray)
    private let weightLabel = UILabel(text: "Weight: 65", font: .robotoMedium18(), textColor: .specialGray)
    
    private var labelsStackView = UIStackView()
    private let profileStatisticCollectionView = ProfileStatisticCollectionView()
    private let targetLabel = UILabel(text: "TARGET: 20 workouts", font: .robotoBold20(), textColor: .specialGray)
    private var valueProgressStackView = UIStackView()
    private let firstProgresLabel = UILabel(text: "2", font: .robotoBold28(), textColor: .specialGray)
    private let secondProgresLabel = UILabel(text: "20", font: .robotoBold28(), textColor: .specialGray)
    
    private let targetView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .specialBrown
        progressView.progressTintColor = .specialGreen
        progressView.layer.cornerRadius = 15
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: true)
        progressView.layer.sublayers?[1].cornerRadius = 15
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

//MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultWorkout = [ResultWorkout]()
        getWorkoutResults()
        profileStatisticCollectionView.reloadData()
    }
    
    //MARK: SetUpView
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(profileLabelTop)
        view.addSubview(greenView)
        view.addSubview(userPhotoImageView)
        greenView.addSubview(nameProfileLabel)
        view.addSubview(editingButton)

        labelsStackView = UIStackView(arrangedSubviews: [heightLabel, weightLabel], axis: .horizontal, spacing: 10)
        view.addSubview(labelsStackView)
        
        profileStatisticCollectionView.delegateProgress = self
        view.addSubview(profileStatisticCollectionView)
        view.addSubview(targetLabel)
        
        valueProgressStackView = UIStackView(arrangedSubviews: [firstProgresLabel, secondProgresLabel], axis: .horizontal, distribution: .equalSpacing)
        secondProgresLabel.textAlignment = .right
        view.addSubview(valueProgressStackView)
        view.addSubview(targetView)
        targetView.addSubview(progressView)
    }
    
    //MARK: - Functions & @objc
    @objc private func editingButtonTapped() {
        let profileSettingsVC = ProfileSettingsViewController()
        profileSettingsVC.modalPresentationStyle = .fullScreen
        present(profileSettingsVC, animated: true)
    }
    
    private func getWorkoutName() -> [String] {
        var nameArray = [String]()
        let allWorkouts = RealmManager.shared.getObjectsWorkoutModel()
        
        for workoutModel in allWorkouts {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getWorkoutResults() {
        let nameArray = getWorkoutName()
        let workoutArray = RealmManager.shared.getObjectsWorkoutModel()
        
        for name in nameArray {
             let predicate = NSPredicate(format: "workoutName = '\(name)'")
            let filtredArray = workoutArray.filter(predicate).sorted(byKeyPath: "workoutName")
            var result = 0
            var image: Data?
            filtredArray.forEach { model in
                if model.workoutStatus {
                    result += model.workoutReps * model.workoutSets
                    image = model.workoutImage
                }
            }
            
            let resultsModel = ResultWorkout(name: name , result: result, imageData: image)
            self.resultWorkout.append(resultsModel)
        }
        profileStatisticCollectionView.setResultsWorkoutArray(array: resultWorkout )
    }
}

extension ProfileViewController: ProgressViewPRotocol {
    func setProgressView() {
        progressView.setProgress(0.6, animated: true)
    }
    
    
}

//MARK: - Layouts
extension ProfileViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            profileLabelTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabelTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userPhotoImageView.topAnchor.constraint(equalTo: profileLabelTop.bottomAnchor, constant: 15),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor),
            
            greenView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            greenView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            nameProfileLabel.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: -15),
            nameProfileLabel.centerXAnchor.constraint(equalTo: greenView.centerXAnchor),
            
            labelsStackView.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20),
            
            editingButton.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 8),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            editingButton.heightAnchor.constraint(equalToConstant: 20),
            
            profileStatisticCollectionView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 25),
            profileStatisticCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            profileStatisticCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            profileStatisticCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            targetLabel.topAnchor.constraint(equalTo: profileStatisticCollectionView.bottomAnchor, constant: 25),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            valueProgressStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 10),
            valueProgressStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valueProgressStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            valueProgressStackView.heightAnchor.constraint(equalToConstant: 30),
            
            targetView.topAnchor.constraint(equalTo: valueProgressStackView.bottomAnchor, constant: 2),
            targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            targetView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.07),
            
            progressView.topAnchor.constraint(equalTo: valueProgressStackView.bottomAnchor, constant: 2),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.07),
        ])
    }
}
