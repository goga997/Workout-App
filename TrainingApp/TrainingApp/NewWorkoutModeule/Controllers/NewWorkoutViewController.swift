//
//  NewWorkoutViewController.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "NEW WORKOUT", font: .robotoBold24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameView = NameVIew()
    private let dateRepeatView = DateRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    private let chooseImageLabel = UILabel(text: "Scroll left and tap to select an image")
    private let backGroundCollView = BackGroundCollectionView()
    private lazy var saveButton = GreenButton(text: "SAVE")
    private var stackView = UIStackView()
    
    //Model Object
    private var workoutModel = WorkoutModel()
    
    private var imageToSave = UIImage(named: ImagesCollectionView.extractedImage?.imageName ?? "closeButton")
    
    //MARK: - Life cycle + setUpView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        offKeyboard()
    }
    
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        stackView = UIStackView(arrangedSubviews: [nameView, dateRepeatView, repsOrTimerView],
                                axis: .vertical, spacing: 10)
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(stackView)
        view.addSubview(chooseImageLabel)
        view.addSubview(backGroundCollView)
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - FUNCTIONALITY
    
    private func offKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        stackView.addGestureRecognizer(tapGesture)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeScreen.cancelsTouchesInView = false
        repsOrTimerView.addGestureRecognizer(swipeScreen)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        setModel()
        saveModel()
    }
    
    //DATABASE Functionality
    private func setModel() {
        workoutModel.workoutName = nameView.getValueFromTextField()
        workoutModel.workoutDate = dateRepeatView.getValueFromDatePickerAndSwitch().date
        workoutModel.workoutRepeat = dateRepeatView.getValueFromDatePickerAndSwitch().isRepeat
        workoutModel.numberOfDay = dateRepeatView.getValueFromDatePickerAndSwitch().date.getWeekDayNumber()
        workoutModel.workoutSets = repsOrTimerView.sets
        workoutModel.workoutReps = repsOrTimerView.reps
        workoutModel.workoutTimer = repsOrTimerView.timer
        
        guard let imageData = imageToSave?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }
    
    private func saveModel() {
        let text = nameView.getValueFromTextField()
        let count = text.filter({$0.isNumber || $0.isLetter}).count
        
        if count != 0 &&
            workoutModel.workoutSets != 0 &&
            (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(workoutModel)
            self.presentSimpleAlert(title: "Saved", message: nil)
            workoutModel = WorkoutModel()
            resetValues()
        } else {
            self.presentSimpleAlert(title: "Failed to Save", message: "Complete all sections \nDo not use symbols!")
        }
    }
    
    private func resetValues() {
        nameView.deleteValueFromTextField()
        dateRepeatView.resetDateAndRepeatSwitch()
        repsOrTimerView.resetSliders()
    }
}

//MARK: - LAYOUTS
extension NewWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            
            nameView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.071),
            dateRepeatView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.145),
            repsOrTimerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.34),

            stackView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            chooseImageLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            chooseImageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            chooseImageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            backGroundCollView.topAnchor.constraint(equalTo: chooseImageLabel.bottomAnchor, constant: 3),
            backGroundCollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backGroundCollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backGroundCollView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            saveButton.topAnchor.constraint(equalTo: backGroundCollView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
}
