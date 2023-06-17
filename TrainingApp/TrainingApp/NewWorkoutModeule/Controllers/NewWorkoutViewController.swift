//
//  NewWorkoutViewController.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel: UILabel = {
       let label = UILabel()
        label.font = .robotoBold24()
        label.text = "NEW WORKOUT"
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private lazy var saveButton = GreenButton(text: "SAVE")
        
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(nameView)
        view.addSubview(dateRepeatView)
        view.addSubview(repsOrTimerView)
        view.addSubview(saveButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        print("save")
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
            
            nameView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 15),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.16),
            
            dateRepeatView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            dateRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateRepeatView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30),
            
            repsOrTimerView.topAnchor.constraint(equalTo: dateRepeatView.bottomAnchor, constant: 20),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            
            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 35),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
